Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbQKTDNV>; Sun, 19 Nov 2000 22:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQKTDNL>; Sun, 19 Nov 2000 22:13:11 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:64495 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130873AbQKTDM7>; Sun, 19 Nov 2000 22:12:59 -0500
Date: Sun, 19 Nov 2000 21:43:21 -0500
From: Ari Pollak <compwiz@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: videodev.c won't compile in test11-pre6/pre7/final
Message-ID: <20001119214321.A23710@darth.ns>
Mail-Followup-To: Ari Pollak <compwiz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux darth.ns 2.4.0-test11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to report this back in pre6, but I thought someone had
caught it already.. When the bttv driver is enbabled as a module in
test11, make modules fails with:

videodev.c: In function `videodev_proc_read':
videodev.c:283: `VID_TYPE_MPEG_DECODER' undeclared (first use in this
function)
videodev.c:283: (Each undeclared identifier is reported only once
videodev.c:283: for each function it appears in.)
videodev.c:284: `VID_TYPE_MPEG_ENCODER' undeclared (first use in this
function)
videodev.c:285: `VID_TYPE_MJPEG_DECODER' undeclared (first use in this
function)videodev.c:286: `VID_TYPE_MJPEG_ENCODER' undeclared (first use
in this function)videodev.c: In function
`video_register_device_Re1d5d9de':
videodev.c:475: structure has no member named `devfs_handle'
videodev.c:476: warning: implicit declaration of function
`devfs_register_R346f2926'
videodev.c:476: `DEVFS_FL_DEFAULT' undeclared (first use in this
function)
videodev.c: In function `video_unregister_device_R0e30839e':
videodev.c:510: warning: implicit declaration of function
`devfs_unregister_Rb8aa48ae'
videodev.c:510: structure has no member named `devfs_handle'
videodev.c: In function `videodev_init':
videodev.c:538: warning: implicit declaration of function
`devfs_register_chrdev_R46ccf2d8'
videodev.c: In function `cleanup_module':
videodev.c:572: warning: implicit declaration of function
`devfs_unregister_chrdev_R77f3e0ce'
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo
make[3]: *** [videodev.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/media/video'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
