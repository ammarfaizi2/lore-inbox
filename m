Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290641AbSAYLav>; Fri, 25 Jan 2002 06:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290644AbSAYLab>; Fri, 25 Jan 2002 06:30:31 -0500
Received: from [62.47.19.142] ([62.47.19.142]:44674 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S290641AbSAYLaY>;
	Fri, 25 Jan 2002 06:30:24 -0500
Message-ID: <3C51416B.37BA635E@webit.com>
Date: Fri, 25 Jan 2002 12:28:43 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SiS DRM, sisfb
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enclosed you find links to

1) a patch for the SiS DRM module. Without this patch, only "root" is
allowed to run DRI applications. The patch will be included in XFree86
as well, but since the module is now also included in the kernel, would
be good to sync these two.

http://www.webit.at/~twinny/sis_drm_patch

2) At http://www.webit.com/tw/linuxsis630.shtml (in the "latest version"
section) there is a revised framebuffer driver for SiS 630 chipset
available. It contains some major improvements for using it on machines
with LCD displays. 

The code is based on the current 2.4.16/17/18 base; I had to include
major new parts so it's not practical to release a patch file. Instead,
the archive contains all files of the directory
"/usr/src/linux/drivers/video/sis/" -  simply to replace the old code.

The improvements only affect machines with LVDS video bridges and LCD
displays; the old driver did not work at all on such computers. (If no
LVDS bridge is detected, the old code is used - so including it into the
offical kernel is safe.)

Both patches have been tested intensivly; sisfb still doesn't work on
_all_ affected machines, but about 80%. (Which is 80% more than
before.... for other machines there's a new parameter "mode=none" so
that people could at least use DRI under X.)

Would be nice if you'd apply/include them. Especially since my X driver
is contained in X 4.2 now...

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com              *** http://www.webit.com/tw
