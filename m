Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSGAK7k>; Mon, 1 Jul 2002 06:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSGAK7j>; Mon, 1 Jul 2002 06:59:39 -0400
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:36883 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S314811AbSGAK7i>; Mon, 1 Jul 2002 06:59:38 -0400
Message-Id: <200207011102.g61B22305958@blake.inputplus.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Date: Mon, 01 Jul 2002 12:02:02 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Does anyone here have a USB Happy Hacking Keyboard Lite Mk 2 keyboard?

On connecting to my 2.4.18 Linux system I find that it works great,
except that certain triples of keys produce four characters instead of
three when typed in rapid succession.  This happens under XFree86 and
also at a tty.  For example, typing `swa' rapidly produces `swaw'.

Further investigation revealed that only certain combination of keys
exhibit the problem.  More examples are

    keys produces
    rty    rtty
    yui    yuui
    tyu    tyuy
    swa    swaw
    jhg    jhgh

But other won't show the problem, e.g. `zxc', `asd', and `qwe'.

My theory is that usbkbd.o doesn't cope with ErrorRollover which is
being generated, unlike hid.o which didn't used to but does now.

    http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.2/1022.html

Diffing 2.4.18's usbkbd.c against 2.5.7 suggests the problem still
exists in 2.5.7.

I'd like to know that others can re-produce the problem.

Cheers,


Ralph.

