Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277419AbRJOLq7>; Mon, 15 Oct 2001 07:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277418AbRJOLqt>; Mon, 15 Oct 2001 07:46:49 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:39696 "EHLO
	smtp.alcove-fr") by vger.kernel.org with ESMTP id <S277414AbRJOLqf>;
	Mon, 15 Oct 2001 07:46:35 -0400
Date: Mon, 15 Oct 2001 13:46:42 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.13-pre1: sonypi.c compile error
Message-ID: <20011015134642.K4523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BCB0A02.9DF231A@zonnet.nl> <200110151055.MAA12072@arpa.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110151055.MAA12072@arpa.it.uc3m.es>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 12:55:48PM +0200, Peter T. Breuer wrote:

> "A month of sundays ago Sander van Geloven wrote:"
> > >
> > > I won't submit a patch to Linus for now, I'm pretty sure that Alan will take care of this for -pre2.
> > > Stelian.
> 
> As far as I recall, I have pre2 and it showed this error on compiling the sony
> vaio stuff. I fixed it by adding an extern int declaration for
> is_sony_vaio_laptop in sonypi.c. It was declared in some nonobvious .c file
> far elsewhere, uh, ... arch/i386/kernel/dmi_scan.c.

This time Linus took the changes for dmi_scan.c/sonypi.c etc which
includes now asm-i386/system.h, but he didn't take the changes
for include/asm/system.h :(

Basically, include/asm-i386/system.h needs to contain:
	extern int is_sony_vaio_laptop;

Alan, could you please fed Linus the exact patch for the next
pre version ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
