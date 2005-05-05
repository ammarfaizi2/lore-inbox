Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVEEQur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVEEQur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVEEQur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:50:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10771 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262150AbVEEQuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:50:08 -0400
Date: Thu, 5 May 2005 18:49:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Luc Saillard <luc@saillard.org>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove drivers/usb/media/pwc/ChangeLog
Message-ID: <20050505164959.GD3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the outdated ChangeLog file for this driver.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/media/pwc/ChangeLog |  143 --------------------------------
 1 files changed, 143 deletions(-)

--- linux-2.6.12-rc3-mm3-full/drivers/usb/media/pwc/ChangeLog	2005-05-05 13:56:19.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,143 +0,0 @@
-9.0.2
-
-* Adding #ifdef to compile PWC before and after 2.6.5
-
-9.0.1
-
-9.0
-
-
-8.12
-
-* Implement motorized pan/tilt feature for Logitech QuickCam Orbit/Spere.
-
-8.11.1
-
-* Fix for PCVC720/40, would not be able to set videomode
-* Fix for Samsung MPC models, appearantly they are based on a newer chipset
-
-8.11
-
-* 20 dev_hints (per request)
-* Hot unplugging should be better, no more dangling pointers or memory leaks
-* Added reserved Logitech webcam IDs
-* Device now remembers size & fps between close()/open()
-* Removed palette stuff altogether
-
-8.10.1
-
-* Added IDs for PCVC720K/40 and Creative Labs Webcam Pro
-
-8.10
-
-* Fixed ID for QuickCam Notebook pro
-* Added GREALSIZE ioctl() call
-* Fixed bug in case PWCX was not loaded and invalid size was set
-
-8.9
-
-* Merging with kernel 2.5.49
-* Adding IDs for QuickCam Zoom & QuickCam Notebook
-
-8.8
-
-* Fixing 'leds' parameter
-* Adding IDs for Logitech QuickCam Pro 4000
-* Making URB init/cleanup a little nicer
-
-8.7
-
-* Incorporating changes in ioctl() parameter passing
-* Also changes to URB mechanism
-
-8.6
-
-* Added ID's for Visionite VCS UM100 and UC300
-* Removed YUV420-interlaced palette altogether (was confusing)
-* Removed MIRROR stuff as it didn't work anyway
-* Fixed a problem with the 'leds' parameter (wouldn't blink)
-* Added ioctl()s for advanced features: 'extended' whitebalance ioctl()s,
-  CONTOUR, BACKLIGHT, FLICKER, DYNNOISE.
-* VIDIOCGCAP.name now contains real camera model name instead of
-  'Philips xxx webcam'
-* Added PROBE ioctl (see previous point & API doc)
-
-8.5
-
-* Adding IDs for Creative Labs Webcam 5
-* Adding IDs for SOTEC CMS-001 webcam
-* Solving possible hang in VIDIOCSYNC when unplugging the cam 
-* Forgot to return structure in VIDIOCPWCGAWB, oops
-* Time interval for the LEDs are now in milliseconds
-
-8.4
-
-* Fixing power_save option for Vesta range
-* Handling new error codes in ISOC callback
-* Adding dev_hint module parameter, to specify /dev/videoX device nodes
-
-8.3
-
-* Adding Samsung C10 and C30 cameras
-* Removing palette module parameter
-* Fixed typo in ID of QuickCam 3000 Pro
-* Adding LED settings (blinking while in use) for ToUCam cameras.
-* Turns LED off when camera is not in use.
-
-8.2
-
-* Making module more silent when trace = 0 
-* Adding QuickCam 3000 Pro IDs
-* Chrominance control for the Vesta cameras
-* Hopefully fixed problems on machines with BIGMEM and > 1GB of RAM
-* Included Oliver Neukem's lock_kernel() patch
-* Allocates less memory for image buffers
-* Adds ioctl()s for the whitebalancing
-
-8.1
-
-* Adding support for 750
-* Adding V4L GAUDIO/SAUDIO/UNIT ioctl() calls
-
-8.0
-* 'damage control' after inclusion in 2.4.5.
-* Changed wait-queue mechanism in read/mmap/poll according to the book.
-* Included YUV420P palette.
-* Changed interface to decompressor module.
-* Cleaned up pwc structure a bit.
-
-7.0
-
-* Fixed bug in vcvt_420i_yuyv; extra variables on stack were misaligned.
-* There is now a clear error message when an image size is selected that
-  is only supported using the decompressor, and the decompressor isn't
-  loaded.
-* When the decompressor wasn't loaded, selecting large image size
-  would create skewed or double images.
-
-6.3
-
-* Introduced spinlocks for the buffer pointer manipulation; a number of
-  reports seem to suggest the down()/up() semaphores were the cause of
-  lockups, since they are not suitable for interrupt/user locking.
-* Separated decompressor and core code into 2 modules.
-
-6.2
-
-* Non-integral image sizes are now padded with gray or black.
-* Added SHUTTERSPEED ioctl().
-* Fixed buglet in VIDIOCPWCSAGC; the function would always return an error,
-  even though the call succeeded.
-* Added hotplug support for 2.4.*.
-* Memory: the 645/646 uses less memory now.
-
-6.1
-
-* VIDIOCSPICT returns -EINVAL with invalid palettes.
-* Added saturation control.
-* Split decompressors from rest.
-* Fixed bug that would reset the framerate to the default framerate if 
-  the rate field was set to 0 (which is not what I intended, nl. do not 
-  change the framerate!).
-* VIDIOCPWCSCQUAL (setting compression quality) now takes effect immediately.
-* Workaround for a bug in the 730 sensor.

