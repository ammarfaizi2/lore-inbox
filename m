Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUBRA0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266911AbUBRAZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:25:53 -0500
Received: from administration2.networld.com ([209.63.232.103]:6413 "EHLO
	networld.com") by vger.kernel.org with ESMTP id S266917AbUBRAY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:24:26 -0500
Message-ID: <4032B084.5020405@networld.com>
Date: Tue, 17 Feb 2004 17:23:32 -0700
From: Charles Johnston <cjohnston@networld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en, pt-br, pt, es, ko, ko-kr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
References: <403274D2.4020407@networld.com>	 <1077055997.1076.23.camel@gaston>  <40329B57.9060901@networld.com> <1077060699.1078.38.camel@gaston>
In-Reply-To: <1077060699.1078.38.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Ok, it worked fine with that line commented out.  I can switch vt's, be 
>>in X, etc. no problems.
> 
> 
> Can you send me the dmesg log still please ?
> 

Here it is:

radeonfb_pci_register BEGIN
radeonfb: probed SDR SGRAM 131072k videoram
radeonfb: mapped 16384k videoram
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=337.00 Mhz, 
System=243.00 MHz
1 chips in connector info
  - chip 1 has 2 connectors
   * connector 0 of type 2 (CRT) : 2300
   * connector 1 of type 4 (DVI-D) : 4210
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Reversed DACs detected
radeonfb: Reversed TMDS detected
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
radeonfb: I2C (port 3) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: U0674^B<9A>M1LW02
radeonfb: detected LVDS panel size from BIOS: 1920x1200
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = 6
post_divider = 1
fbk_divider = 48
Scanning BIOS table ...
  320 x 350
  320 x 400
  320 x 400
  320 x 480
  400 x 600
  512 x 384
  640 x 350
  640 x 400
  640 x 475
  640 x 480
  720 x 480
  720 x 576
  800 x 600
  848 x 480
  1024 x 768
  1280 x 1024
  1280 x 768
  1280 x 800
  1600 x 1200
  1680 x 1050
  1920 x 1200
Found panel in BIOS table:
   hblank: 264
   hOver_plus: 96
   hSync_width: 32
   vblank: 35
   vOver_plus: 2
   vSync_width: 6
   clock: 16175
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NP  SDR SGRAM 128 MB
radeonfb_pci_register END

hStart = 2016, hEnd = 2048, hTotal = 2184
vStart = 1202, vEnd = 1208, vTotal = 1235
h_total_disp = 0xef0110	   hsync_strt_wid = 0x407da
v_total_disp = 0x4af04d2	   vsync_strt_wid = 0x604b1
pixclock = 6182
freq = 16175
lvds_gen_cntl: 003cffa5


> 
>>The only issue I see is when I do a 'clear' on the vt, it doesn't clear 
>>the text, but blanks every nth row of pixels.  Switching vt's and back 
>>clears the screen.
> 
> 
> Does this happen even without using XFree ? There is a known problem
> with clears when switching _from_ XFree... I'm working on a fix.
> 

Yes, the blanking issue is still present without XFree.

> 
>>There are also a few rows of garbage pixels at the bottom that linger 
>>across vt switches.
> 
> 
> Yes, same as above afaik
> 

The bottom garbage is not present without XFree.
