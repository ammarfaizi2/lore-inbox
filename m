Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRB0Npj>; Tue, 27 Feb 2001 08:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRB0Np3>; Tue, 27 Feb 2001 08:45:29 -0500
Received: from [212.115.175.146] ([212.115.175.146]:11261 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129359AbRB0NpQ>; Tue, 27 Feb 2001 08:45:16 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F2E@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Ivo Timmermans <irt@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: binfmt_script and ^M
Date: Tue, 27 Feb 2001 14:53:48 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When running a script (perl in this case) that has DOS-style newlines
> > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > recognize the \r.  The following patch should fix this (untested).
> _should_ it work with the \r in it?
IV> IMHO, yes.  This set of files were created on Windows, then zipped and
IV> uploaded to a Linux server, unpacked.  This does not change the \r.

But; it's not that much of hassle to run it trough some awk/sed/whatsoever
script, would it? Imho there should be as less as possible code in the
kernel which could've also been done in user-space.

> +	if (cp - 1 == '\r')				<------- *)
> There might be a problem with your patch: at the '*)': if the '\n' is the
> first character on the line, the cp-1 (which should be *(cp-1) I think)
IV> You're right there.

Phew, then I have at least 1 thing right in my message since I was wrong
with:

> would point before the buffer which can be un-allocated memory.

If only I had read the code myself :o)

IV> No, the first two characters are always `#!'.

Yes, absolutely right.
