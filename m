Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284676AbRLIXuv>; Sun, 9 Dec 2001 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284675AbRLIXuf>; Sun, 9 Dec 2001 18:50:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50194 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284676AbRLIXtJ>; Sun, 9 Dec 2001 18:49:09 -0500
Subject: Re: Linux 2.4.17-pre5
To: kravetz@us.ibm.com (Mike Kravetz)
Date: Sun, 9 Dec 2001 23:57:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        rusty@rustcorp.com.au (Rusty Russell), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20011209144433.B1087@w-mikek2.sequent.com> from "Mike Kravetz" at Dec 09, 2001 02:44:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DDpL-0008IF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This implies that the idle loop will poll looking for work to do.
> Is that correct?  Davide's scheduler also does this.  I believe
> the current default idle loop (at least for i386) does as little
> as possible and stops execting instructions.  Comments in the code
> mention power consumption.  Should we be concerned with this?

You can poll or IPI. An IPI has the problem that IPI's are horribly slow
on Pentium II/III. On the other hand the Athlon and PIV seem to both have
that bit sorted.

Its really an implementation detail as to whether you poll for work or
someone kicks you. Since we know what the other processors are doing and
who is idle we know when we need to kick them.

Alan
