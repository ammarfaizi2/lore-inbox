Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263108AbTDBSin>; Wed, 2 Apr 2003 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbTDBSim>; Wed, 2 Apr 2003 13:38:42 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.28]:64081 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263108AbTDBSii>; Wed, 2 Apr 2003 13:38:38 -0500
From: Fendrakyn <fendrakyn@europaguild.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] E7x05 chipset bug in 2.5 kernels' AGPGART driver. 
Date: Wed, 2 Apr 2003 20:50:03 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304022050.03026.fendrakyn@europaguild.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed there is a bug in E7x05 (Granite Bay) chipset support of the AGPGART 
driver that does not seem to have been submitted yet.

There is a mistake in the Makefile of drivers/char/agp, the line concerning 
i7x05-agp support does not match the one in the Kconfig, thus e7x05 support 
is never compiled, be it as a module or in the kernel.

There are mistakes in the i7x05-agp source code. A few missings ";" and some 
undeclared functions prevent the module from properly compiling. Those 
mistakes are easily fixed though.

The last problem is more important and I have yet to find a solution. It seems 
like the driver stores device 0 in his agp_bridge->dev (0x255d for E7205, 
0x2550 for E7505) but it uses registers from device 1 (0x2552) thus the 
chipset cannot be configured properly. The fetch_size function fails to 
determine aperture size.

Sorry if this is redundant and is already being looked at.


Gareth C.



P.S : include answers in C.C if you may, pretty please.










