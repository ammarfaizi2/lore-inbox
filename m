Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJGBat>; Sat, 6 Oct 2001 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276018AbRJGBab>; Sat, 6 Oct 2001 21:30:31 -0400
Received: from 209.249.55.160.voxel.net ([209.249.55.160]:6407 "EHLO
	cheetah.linux-vs.org") by vger.kernel.org with ESMTP
	id <S276014AbRJGBaK>; Sat, 6 Oct 2001 21:30:10 -0400
Date: Sun, 7 Oct 2001 09:30:31 +0800
From: Wenzhuo Zhang <wenzhuo@zhmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-ID: <20011007093030.A18781@zhmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de> <1001988137.2780.53.camel@phantasy> <20011002151051.488306ee.efkemann@uni-bremen.de> <1002066345.1003.66.camel@phantasy> <20011003021658.O7800@khan.acc.umu.se> <1002075650.1237.2.camel@phantasy> <20011006164734.B26380@ChaoticDreams.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011006164734.B26380@ChaoticDreams.ORG>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 04:47:34PM -0700, Paul Mundt wrote:
> On Tue, Oct 02, 2001 at 10:20:43PM -0400, Robert Love wrote:
> > I suppose we could, and this is a good idea -- although we'd be
> > reapproaching the size of the current implementation which would be
> > theoretically faster, too.
> > 
> > There are only 3 possibilities right now (i830, i840, and everything
> > else).
> > 
> Make that i830, i840, i850, i860 and everything else. A better way for
> dealing with specialized configure routines for these various chipsets
> would definately seem to be in order. Between i840/i850/i860, there's
> very little difference except for what bits to clear in the ERRSTS register.
> 
> It would be nice to be able to get the 840/850/860 down to just a few lines
> of code a peice instead of this huge overlap of generic routines thats
> happening currently.
> 
> Here's a patch for i860..
> 

May I ask how to implement agp_bridge.configure for i845? Dell Dimension
4300 uses this chipset.

# lspci
00:00.0 Host bridge: Intel Corporation: Unknown device 1a30 (rev 03)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1a31 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 12)
00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 12)
00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE U100 (rev 12)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 12)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 12)
00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 12)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 12)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5446
02:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)

# lspci -n
00:00.0 Class 0600: 8086:1a30 (rev 03)
00:01.0 Class 0604: 8086:1a31 (rev 03)
00:1e.0 Class 0604: 8086:244e (rev 12)
00:1f.0 Class 0601: 8086:2440 (rev 12)
00:1f.1 Class 0101: 8086:244b (rev 12)
00:1f.2 Class 0c03: 8086:2442 (rev 12)
00:1f.3 Class 0c05: 8086:2443 (rev 12)
00:1f.4 Class 0c03: 8086:2444 (rev 12)
00:1f.5 Class 0401: 8086:2445 (rev 12)
01:00.0 Class 0300: 1002:5446
02:09.0 Class 0200: 1282:9102 (rev 31)

-- 
Wenzhuo
  GnuPG Key ID 0xBA586A68
  Key fingerprint = 89C7 C6DE D956 F978 3F12  A8AF 5847 F840 BA58 6A68
