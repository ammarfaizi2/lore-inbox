Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132950AbRADNSK>; Thu, 4 Jan 2001 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133007AbRADNRu>; Thu, 4 Jan 2001 08:17:50 -0500
Received: from slc142.modem.xmission.com ([166.70.9.142]:54536 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132950AbRADNRr>; Thu, 4 Jan 2001 08:17:47 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: kai@thphy.uni-duesseldorf.de (Kai Germaschewski),
        geroldj@grips.com (Gerold Jury),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List), dl8bcu@gmx.net,
        Maik.Zumstrull@gmx.de
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <200101032232.f03MW5R08633@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2001 05:03:00 -0700
In-Reply-To: Russell King's message of "Wed, 3 Jan 2001 22:32:05 +0000 (GMT)"
Message-ID: <m11yujjzij.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> Kai Germaschewski writes:
> > The patch is right, the explanation was wrong. Sorry, I didn't CC l-k when
> > I found what was really going on. Other source files used a global
> > initialized variable "divert_if" as well, so this became the same one as
> > the one referenced in isdn_common.c.  That's why it wasn't zero, it was
> > explicitly initialized elsewhere. However, making divert_if static in
> > isdn_common.c fixes the problem, because now it's really local to this
> > file and therefore initialized to NULL.
> 
> Maybe someone should compile the kernel with everything built in and
> -fno-common to catch stuff like this?  Maybe we should always compile
> the kernel with -fno-common?

Sounds good.

We probably need to wait until after 2.4.0 is released to make the 
change though.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
