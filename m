Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279656AbRJYAKS>; Wed, 24 Oct 2001 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279652AbRJYAKL>; Wed, 24 Oct 2001 20:10:11 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:46084 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279655AbRJYAKC>;
	Wed, 24 Oct 2001 20:10:02 -0400
Message-Id: <5.1.0.14.0.20011025095740.024859b0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Oct 2001 10:10:34 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS630S FrameBuffer & LCD
Cc: Henrique de Moraes Holschuh <hmh@debian.org>,
        Robert Vojta <robert@v0jta.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20011024095423.E1178@ipex.cz>
In-Reply-To: <E15w5Yw-0000Q5-00@the-village.bc.nu>
 <20011023153015.F4709@khazad-dum>
 <E15w5Yw-0000Q5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:54 AM 24/10/01 +0200, Robert Vojta wrote:

>   AFAIK the new informations from SiS are still doesn't working. I have 
> this SiS630 chipset too and I must use VesaFB for correct chipset 
> initialization and correct settings. VesaFB must have the same resolution 
> and bpp which I want in X. And I can use accelerated functions in X (not 
> FB) by ugly hack in sis_driver.c like, so it leaves settings from VesaFB 
> and functions like SiSPreSetMode(pScrn) 
> and  SiSSetMode(xf86Screens[scrnIndex], mode) are skipped. I have this 
> driver (precompiled) available on my pages 
> http://www.v0jta.net/gericom/gericom.php3?&menu=4#vga with all steps how 
> to make this chipset working with linux.

I have a similar patch at...
  http://members.optushome.com.au/cefiar1/sis_vesa_fb_hack.diff
..which does the same, except you need to add...

Option  "VesaFBHack" "true"

..to the Drivers section of your XF86Config-4 file to enable it.

Got a binary as well, search the XFree86 Xpert list if you want more info.

If the kernel SiS FrameBuffer driver is fixed first, this way will still 
work, and maybe a more decent XFree86 patch could use the FrameBuffer mode 
sets and so on to change modes, till the XFree86 driver is fixed, and 
providing such info to the XFree86 team to fix the bug there as well. I 
have yet to hear anything from SiS (and a few SiS employees are on l-k as 
well as Xpert) on what they think this could be, or about up-to-date docs.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

