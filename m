Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSGARQr>; Mon, 1 Jul 2002 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSGARQq>; Mon, 1 Jul 2002 13:16:46 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:34629 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315870AbSGARQp>; Mon, 1 Jul 2002 13:16:45 -0400
Message-Id: <5.1.0.14.2.20020701181432.00af73c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 01 Jul 2002 18:19:53 +0100
To: Ralph Corderoy <ralph@inputplus.co.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207011102.g61B22305958@blake.inputplus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:02 01/07/02, Ralph Corderoy wrote:
>Does anyone here have a USB Happy Hacking Keyboard Lite Mk 2 keyboard?

I have two of the Mk2 and one of the Mk1 keyboards and none of them exhibit 
the problems you have (using 3 different systems with kernels both 
2.4.18-pre7-ac2+ide+other stuff, 2.4.18-pre3+ide+other stuff and 
2.5.24+ntfs-2.0.13). The difference being I am using the full HID drivers 
(I tried both) and never the cutdown usbkbd driver. (I have many other usb 
devices including my mouse, digital camera, webcam, etc, so can't use usbkbd.)

So as other people have suggested, use the full hid driver and be happy. (-:

Best regards,

         Anton

>On connecting to my 2.4.18 Linux system I find that it works great,
>except that certain triples of keys produce four characters instead of
>three when typed in rapid succession.  This happens under XFree86 and
>also at a tty.  For example, typing `swa' rapidly produces `swaw'.
>
>Further investigation revealed that only certain combination of keys
>exhibit the problem.  More examples are
>
>     keys produces
>     rty    rtty
>     yui    yuui
>     tyu    tyuy
>     swa    swaw
>     jhg    jhgh
>
>But other won't show the problem, e.g. `zxc', `asd', and `qwe'.
>
>My theory is that usbkbd.o doesn't cope with ErrorRollover which is
>being generated, unlike hid.o which didn't used to but does now.
>
>     http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.2/1022.html
>
>Diffing 2.4.18's usbkbd.c against 2.5.7 suggests the problem still
>exists in 2.5.7.
>
>I'd like to know that others can re-produce the problem.
>
>Cheers,
>
>
>Ralph.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

