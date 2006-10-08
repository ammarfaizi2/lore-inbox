Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWJHKM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWJHKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWJHKM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:12:57 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:38637 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751027AbWJHKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:12:56 -0400
Date: Sun, 8 Oct 2006 12:12:31 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: monitor not active after boot (was Re: Merge window closed: v2.6.19-rc1)
Message-ID: <20061008101231.GA20039@aepfle.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005210936.GA29654@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061005210936.GA29654@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, Olaf Hering wrote:

> If my monitor is off during boot and I turn it on once KDE is fully
> started, the screen remains black. If it stays on during boot, X will
> work ok. This happens on a G5 with ' nVidia Corporation NV43 [GeForce 6600] (rev a2)'
> The i2c errors are new.

I dont know how Xorg gets the EDID data. There is no difference in dmesg
output with monitor on/off. But the Xorg.0.log shows:

@@ -772,49 +772,13 @@
 (II) NV(0): Probing for EDID on I2C bus B...
 (II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
 (II) NV(0): I2C device "DDC:ddc2" removed.
-(--) NV(0): DDC detected a CRT:
-(II) NV(0): Manufacturer: ACT  Model: f1b  Serial#: 8016154
-(II) NV(0): Year: 1998  Week: 9
-(II) NV(0): EDID Version: 1.0
-(II) NV(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
-(II) NV(0): Sync:  Separate  Composite
-(II) NV(0): Max H-Image Size [cm]: horiz.: 28  vert.: 21
-(II) NV(0): Gamma: 2.00
-(II) NV(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
-(II) NV(0): redX: 0.625 redY: 0.339   greenX: 0.301 greenY: 0.599
-(II) NV(0): blueX: 0.141 blueY: 0.065   whiteX: 0.281 whiteY: 0.310
-(II) NV(0): Supported VESA Video Modes:
-(II) NV(0): 720x400@70Hz
-(II) NV(0): 640x480@60Hz
-(II) NV(0): 640x480@75Hz
-(II) NV(0): 800x600@60Hz
-(II) NV(0): 800x600@75Hz
-(II) NV(0): 1024x768@60Hz
-(II) NV(0): 1024x768@70Hz
-(II) NV(0): 1024x768@75Hz
-(II) NV(0): Manufacturer's mask: 0
-(II) NV(0): Supported additional Video Mode:
-(II) NV(0): clock: 36.0 MHz   Image Size:  280 x 210 mm
-(II) NV(0): h_active: 640  h_sync: 696  h_sync_end 752 h_blank_end 832 h_border: 0
-(II) NV(0): v_active: 480  v_sync: 481  v_sync_end 484 v_blanking: 509 v_border: 0
-(II) NV(0): Supported additional Video Mode:
-(II) NV(0): clock: 56.2 MHz   Image Size:  280 x 210 mm
-(II) NV(0): h_active: 800  h_sync: 832  h_sync_end 896 h_blank_end 1048 h_border: 0
-(II) NV(0): v_active: 600  v_sync: 601  v_sync_end 604 v_blanking: 631 v_border: 0
-(II) NV(0): Supported additional Video Mode:
-(II) NV(0): clock: 94.5 MHz   Image Size:  280 x 210 mm
-(II) NV(0): h_active: 1024  h_sync: 1072  h_sync_end 1168 h_blank_end 1376 h_border: 0
-(II) NV(0): v_active: 768  v_sync: 769  v_sync_end 772 v_blanking: 808 v_border: 0
-(II) NV(0): Supported additional Video Mode:
-(II) NV(0): clock: 108.0 MHz   Image Size:  280 x 210 mm
-(II) NV(0): h_active: 1280  h_sync: 1328  h_sync_end 1440 h_blank_end 1688 h_border: 0
-(II) NV(0): v_active: 1024  v_sync: 1025  v_sync_end 1028 v_blanking: 1066 v_border: 0
+(II) NV(0):   ... none found
 (--) NV(0): CRTC 0 appears to have a CRT attached
 (II) NV(0): Using CRT on CRTC 0
 (--) NV(0): VideoRAM: 262144 kBytes
 (==) NV(0): Using gamma correction (1.0, 1.0, 1.0)
-(II) NV(0): Monitor[0]: Using default hsync range of 43.26-68.68 kHz
-(II) NV(0): Monitor[0]: Using default vrefresh range of 60.01-85.06 Hz
+(II) NV(0): Monitor[0]: Using default hsync range of 28.00-33.00 kHz
+(II) NV(0): Monitor[0]: Using default vrefresh range of 43.00-72.00 Hz
 (II) NV(0): Clock range:  12.00 to 400.00 MHz
 (II) NV(0): Not using default mode "640x350" (hsync out of range)
 (II) NV(0): Not using default mode "320x175" (hsync out of range)


The root cause may be that Xorg nv can not handle 640x480@xx at all on this card,
or this monitor. It works ok in OSX.
Also turning the monitor off while in yaboot doesnt help.
tree -f /sys shows also no difference.
