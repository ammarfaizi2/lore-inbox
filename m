Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRB0Nit>; Tue, 27 Feb 2001 08:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbRB0Nii>; Tue, 27 Feb 2001 08:38:38 -0500
Received: from janeway.cistron.net ([195.64.65.23]:1291 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S129305AbRB0Ni2>; Tue, 27 Feb 2001 08:38:28 -0500
Date: Tue, 27 Feb 2001 14:38:23 +0100
From: Ivo Timmermans <irt@cistron.nl>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010227143823.A25058@cistron.nl>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Tue, Feb 27, 2001 at 02:42:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heusden, Folkert van wrote:
> > When running a script (perl in this case) that has DOS-style newlines
> > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > recognize the \r.  The following patch should fix this (untested).
> 
> _should_ it work with the \r in it?

IMHO, yes.  This set of files were created on Windows, then zipped and
uploaded to a Linux server, unpacked.  This does not change the \r.

> There might be a problem with your patch: at the '*)': if the '\n' is the
> first character on the line, the cp-1 (which should be *(cp-1) I think)

You're right there.

> would point before the buffer which can be un-allocated memory.

No, the first two characters are always `#!'.

> +	if (cp - 1 == '\r')				<------- *)


-- 
Ivo Timmermans
