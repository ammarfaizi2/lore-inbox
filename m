Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbQKTE4j>; Sun, 19 Nov 2000 23:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbQKTE4V>; Sun, 19 Nov 2000 23:56:21 -0500
Received: from rmx441-mta.mail.com ([165.251.48.44]:44286 "EHLO
	rmx441-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129977AbQKTEre>; Sun, 19 Nov 2000 23:47:34 -0500
Message-ID: <383392987.974693853627.JavaMail.root@web694-wra.mail.com>
Date: Sun, 19 Nov 2000 23:17:30 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: Ari Pollak <compwiz@bigfoot.com>
Subject: RE: videodev.c won't compile in test11-pre6/pre7/final
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.147
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  The undeclared variables are defined in include/linux/videodev.h , which is included in videodev.c .

...
#define VID_TYPE_SUBCAPTURE 512
#define VID_TYPE_MPEG_DECODER 1024
#define VID_TYPE_MPEG_ENCODER 2048
#define VID_TYPE_MJPEG_DECODER 4096
#define VID_TYPE_MJPEG_ENCODER 8192
...

Regards,
Frank

--On Sunday, November 19, 2000 9:43 PM -0500 Ari Pollak <compwiz@bigfoot.com> wrote:

> I was going to report this back in pre6, but I thought someone had
> caught it already.. When the bttv driver is enbabled as a module in
> test11, make modules fails with:
> 
> videodev.c: In function `videodev_proc_read':
> videodev.c:283: `VID_TYPE_MPEG_DECODER' undeclared (first use in this
> function)
> videodev.c:283: (Each undeclared identifier is reported only once
> videodev.c:283: for each function it appears in.)
> videodev.c:284: `VID_TYPE_MPEG_ENCODER' undeclared (first use in this
> function)
> videodev.c:285: `VID_TYPE_MJPEG_DECODER' undeclared (first use in this
> function)videodev.c:286: `VID_TYPE_MJPEG_ENCODER' undeclared (first use
> in this function)videodev.c: In function
> `video_register_device_Re1d5d9de':
> videodev.c:475: structure has no member named `devfs_handle'
> videodev.c:476: warning: implicit declaration of function
> `devfs_register_R346f2926'
> videodev.c:476: `DEVFS_FL_DEFAULT' undeclared (first use in this
> function)
> videodev.c: In function `video_unregister_device_R0e30839e':
> videodev.c:510: warning: implicit declaration of function
> `devfs_unregister_Rb8aa48ae'
> videodev.c:510: structure has no member named `devfs_handle'
> videodev.c: In function `videodev_init':
> videodev.c:538: warning: implicit declaration of function
> `devfs_register_chrdev_R46ccf2d8'
> videodev.c: In function `cleanup_module':
> videodev.c:572: warning: implicit declaration of function
> `devfs_unregister_chrdev_R77f3e0ce'
> {standard input}: Assembler messages:
> {standard input}:8: Warning: Ignoring changed section attributes for
> .modinfo
> make[3]: *** [videodev.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/drivers/media/video'
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
