Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUBQS4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUBQS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:56:52 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:58754 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S266448AbUBQS4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:56:49 -0500
Message-ID: <403263EE.9010609@emergence.uk.net>
Date: Tue, 17 Feb 2004 18:56:46 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc4
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok,
>  I'm planning on doing the final 2.6.3 tomorrow, so please test this 
> final -rc.
> 
> Most notably, this should support ppc/ppc64 out-of-the-box, complete with
> G5 support (64-bit). Special thanks to BenH who made sure the new radeonfb
> driver works on a wide variety of hardware (a number of the fixes here
> relative to -rc3 was making sure the driver works on regular x86 laptops).

There are still two problems with the radeonfb on my IBM X31:

1) The screen is garbled when the fb kicks in at boot - its not 
converting the text from the VGA console correctly. I have a photo of 
this here: http://emergence.uk.net/radeonfb_corruption.jpeg

2) If I run X and then exit X or switch to a fb vt then the bottom line 
doesn't clear when scrolling and running `clear` only clears the middle 
line of pixels on each line of text.

radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 16384k videoram
radeonfb: mapped 16384k videoram
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, 
System=144.00 MHz
1 chips in connector info
  - chip 1 has 1 connectors
   * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768
radeonfb: detected LVDS panel size from BIOS: 1024x768
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = 8
post_divider = 2
fbk_divider = 4d
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
Found panel in BIOS table:
   hblank: 320
   hOver_plus: 16
   hSync_width: 136
   vblank: 38
   vOver_plus: 2
   vSync_width: 6
   clock: 6500
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LY  DDR SGRAM 16 MB
radeonfb_pci_register END


Jonathan Brown
http://emergence.uk.net/
