Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130319AbRACWck>; Wed, 3 Jan 2001 17:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbRACWcU>; Wed, 3 Jan 2001 17:32:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129226AbRACWcQ>;
	Wed, 3 Jan 2001 17:32:16 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101032232.f03MW5R08633@flint.arm.linux.org.uk>
Subject: Re: Happy new year^H^H^H^Hkernel..
To: kai@thphy.uni-duesseldorf.de (Kai Germaschewski)
Date: Wed, 3 Jan 2001 22:32:05 +0000 (GMT)
Cc: ebiederm@xmission.com (Eric W. Biederman), geroldj@grips.com (Gerold Jury),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List), dl8bcu@gmx.net,
        Maik.Zumstrull@gmx.de
In-Reply-To: <Pine.LNX.4.30.0101032201290.8073-100000@vaio> from "Kai Germaschewski" at Jan 03, 2001 11:06:36 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski writes:
> The patch is right, the explanation was wrong. Sorry, I didn't CC l-k when
> I found what was really going on. Other source files used a global
> initialized variable "divert_if" as well, so this became the same one as
> the one referenced in isdn_common.c.  That's why it wasn't zero, it was
> explicitly initialized elsewhere. However, making divert_if static in
> isdn_common.c fixes the problem, because now it's really local to this
> file and therefore initialized to NULL.

Maybe someone should compile the kernel with everything built in and
-fno-common to catch stuff like this?  Maybe we should always compile
the kernel with -fno-common?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
