Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270438AbRIBXgI>; Sun, 2 Sep 2001 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRIBXfs>; Sun, 2 Sep 2001 19:35:48 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:45212 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S270438AbRIBXfg>; Sun, 2 Sep 2001 19:35:36 -0400
Date: Sun, 2 Sep 2001 19:35:55 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: pvr2fb.c
Message-ID: <Pine.GSO.4.33.0109021930580.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What the ^*!#^% is this:

driver/video/pvr2fb.c:
int __init pvr2fb_init(void)
{
        struct fb_var_screeninfo var;
        u_long modememused;

        if (!MACH_DREAMCAST)
                return -ENXIO;
...

That's the first time I've seen such, well, badness.

It looks like someone forgot what platform is *required* for the PowerVR 2...

drivers/video/Config.in:
   tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
   dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2

--Ricky

PS: Compiling 2.4.9 on an Alpha is turning up all manner of weird stuff.  Like
    a lot of drivers that aren't 64bit clean, missing parts of asm-alpha...


