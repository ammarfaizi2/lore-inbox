Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTAKEdx>; Fri, 10 Jan 2003 23:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTAKEdx>; Fri, 10 Jan 2003 23:33:53 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:48309 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267048AbTAKEdw>; Fri, 10 Jan 2003 23:33:52 -0500
Date: Fri, 10 Jan 2003 23:41:13 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: 2.5.56 kernel floppy driver bug
To: linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042260073.1385.175.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change I described recently that needs to be made to the floppy
driver (Changing "if (NO GEOM){" to "if (1) {" in floppy_revalidate() in
drivers/block/floppy.c) still has to happen in the latest kernel to fix
a problem where you try to open the floppy device without a disk in the
drive and the OS doesn't always tell you ENXIO..  It tells you every few
times ENXIO, but not every time...

The patch is above in my text...  It's simple to apply.. It's more
difficult, but if you want me to do a diff patch, I'll do it.

The patch will probably break something else, but it will at least fix
this issue, which someone else complained about.

-Rob

