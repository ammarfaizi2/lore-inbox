Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRKNSwj>; Wed, 14 Nov 2001 13:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRKNSw3>; Wed, 14 Nov 2001 13:52:29 -0500
Received: from ppp-210-124.21-151.libero.it ([151.21.124.210]:14852 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP
	id <S274875AbRKNSwT>; Wed, 14 Nov 2001 13:52:19 -0500
Date: Wed, 14 Nov 2001 20:51:41 +0100
From: Daniele Venzano <venza@iol.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Subject: Problem with i820 AGP patch
Message-ID: <20011114205141.A1065@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch to add AGP support for i820 chipset doesn't work for me, if I
load agpgart module with agp_try_unsupported=1 I get:

-
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Trying generic Intel routines for device id: 2501
						^^^^^^^^^^^^^
agpgart: AGP aperture is 256M @ 0xd0000000
-

That device id is different from the corresponding line in apg.h:174
#define PCI_DEVICE_ID_INTEL_820_0       0x2500

I tried to change that line in:
#define PCI_DEVICE_ID_INTEL_820_0       0x2501

And it worked! But I don't know why the id for your chip is different
from mine... 

My motherboard is an Asus P3C2000 with a P3 500 running kernel 2.4.14


I've also another problem (I think AGP related) with DRI/DRM ang XFree
4.1.0, but I'm still working on it.
If I try running some OpenGL app with more than 256Mb of RAM, the system hangs
(need hard reset, no SysReq works). This happens with 2.4.13 and 2.4.14,
before I hadn't tried since I had only 128Mb...)
Someone can please tell me if this problem has something to do with
having a "Maximum main memory to use for agp memory" value grater than
AGP aperture value ?


Regards,
-- 
------------------------------------------------------------
Daniele Venzano
Senior member of the Linux User Group Genova, Italy (LUGGe)
E-Mail: venza@iol.it
Web: http://digilander.iol.it/webvenza/
LUGGe: http://lugge.ziobudda.net

