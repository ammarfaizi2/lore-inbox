Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTDQGNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 02:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTDQGNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 02:13:01 -0400
Received: from granite.he.net ([216.218.226.66]:29714 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264336AbTDQGM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 02:12:58 -0400
Date: Wed, 16 Apr 2003 23:25:46 -0700
From: Greg KH <greg@kroah.com>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: vesa fb in -bk gives too many console lines
Message-ID: <20030417062546.GA3114@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the latest -bk tree, using the vesa fb driver, I get a window that is
much too big for my screen.  I'm using "vga=0x0305" as a command line
option, which I've been using for years on this box, and when the fb
code kicks in, it creates a screen that has more lines than are
displayed on the monitor (text lines that is).  I can see 48 lines, but
it's acting like there are more that that present.

Is this just an operator error, in that I need to provide a different
command line option now for the size of the console screen?

Here's the relevant portions of the boot messages:

vesafb: framebuffer at 0xd5000000, mapped to 0xf080d000, size 4096k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c000:0310
vesafb: scrolling: redraw
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: VSC Model: 8f00 Serial#: 16843009
   Year: 2001 Week 20
   Display Characteristics:
      Analog Display Input: Input Voltage - 0.700V/0.300V
      Configurable signal level
      Sync: Separate Composite Serration on 
      Max H-size in cm: 37
      Max V-size in cm: 27
      Gamma: 2.86
      DPMS: Active yes, Suspend yes, Standby yes
      RGB Color Display
      Chromaticity: RedX:   0.638 RedY:   0.325
                    GreenX: 0.276 GreenY: 0.596
                    BlueX:  0.143 BlueY:  0.066
                    WhiteX: 0.283 WhiteY: 0.297
      First DETAILED Timing is preferred
      Display is GTF capable
   Standard Timings
      1280x1024@85Hz
      1280x1024@60Hz
      1152x864@75Hz
      1024x768@85Hz
      800x600@85Hz
      640x480@85Hz
      1600x1200@60Hz
      1600x1200@75Hz
   Supported VESA Modes
      720x400@70Hz
      720x400@88Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@87Hz (interlaced)
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Detailed Monitor Information
      157 MHz 1280 1344 1504 1728 1024 1025 1028 1072 +HSync +VSync

      Serial No     : 320012039515
      HorizSync     : 30-95 KHz
      VertRefresh   : 50-180 Hz
      Max Pixelclock: 200 MHz
      Monitor Name  : A90-2
========================================
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 160x64

thanks,

greg k-h

p.s. nice boot messages, I know now that the usb code will stop taking
the heat for abusing the kernel log :)
