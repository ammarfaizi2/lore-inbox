Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDKINV>; Wed, 11 Apr 2001 04:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDKINN>; Wed, 11 Apr 2001 04:13:13 -0400
Received: from eva.bm.ipex.cz ([212.71.138.2]:54056 "EHLO eva.bm.ipex.cz")
	by vger.kernel.org with ESMTP id <S132527AbRDKIM6>;
	Wed, 11 Apr 2001 04:12:58 -0400
Date: Wed, 11 Apr 2001 10:15:13 +0200
From: Robert Vojta <vojta@ipex.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: SiS 630
Message-ID: <20010411101513.A1804@ipex.cz>
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B7D@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B7D@mail0.myrio.com>; from torrey.hoffman@myrio.com on Tue, Apr 10, 2001 at 10:09:45AM -0700
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I have this chipset in my new notebook (Gericom Webboy). Everything works
fine, but only modem doesn't work because it's software modem. I tried to
search net for drivers, tried to write to SiS (no aswer for two weeks ;(),
etc. -> no success.
  But, if you have this chipset in notebook you should have problems with
LCD display with SiS chipset. I have tried XServer from SiS, XFree 3.3.x
and XFree 4.x and no success. Every try I see blank noisy display ;(
Everything work, but only display is not properly set. So, I tried
kernel frame buffer support and it partly works - SiS kernel frame buffer
support doesn't work too, kernel VESA frame buffer support works fine.
Next thing is, that if you want for instance 1024x768 resolution in X,
you must set up vesa frame buffer to 1024x768 resolution too ;(
  So, if you have notebook with this chipset and want X support, you must
set kernel VESA frame buffer support (not SiS support!) and set the same
resolution for frame buffer and for X. When you see blank noisy display
everything works fine, X started, applications too but they are invisible
due to bad display setting.

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
  Ethernet (rev 80)

  Network device support  --->
    Ethernet (10 or 100Mbit)  --->
      < > SiS 900/7016 PCI Fast Ethernet Adapter support

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)

  USB support  ---> (works fine)

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]:
  Unknown device 7018 (rev 01)

  Sound  --->
    < > Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core

00:03.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6872 (rev 05)

  General setup  --->
    PCMCIA/CardBus support  --->
      < > PCMCIA/CardBus support                                                     
      [ ]   CardBus support
      [ ]   i82365 compatible bridge support

  R.obot.V

-- 
   _
  |-|  __      Robert Vojta <vojta@ipex.cz>          -= Oo.oO =-
  |=| [Ll]     IPEX, s.r.o.
  "^" ====`o
