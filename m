Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317060AbSEXBB2>; Thu, 23 May 2002 21:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317061AbSEXBB1>; Thu, 23 May 2002 21:01:27 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:47527 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317060AbSEXBB0> convert rfc822-to-8bit; Thu, 23 May 2002 21:01:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: 2.2.x and DRM Modules / AGPgart
Date: Fri, 24 May 2002 03:01:11 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205240255.21249.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

again this question to the 2.2. Kernel tree, why this kernels does not have 
the new DRM Engine? Its out since January 2002.

Another issue i've noticed is, if you want to load a drm module, you have to 
load agpgart.o before, otherwise it won't load and even won't work. But if 
you have a PCI Card, agpgart is superflous and will not load, so the DRM 
Module cannot be loaded too.

This works fine with 2.4 Kernel tree, but not with 2.2 Kernel tree. Actually 
tested 2.2.21.


insmod: /lib/modules/2.2.21/misc/r128.o: insmod r128 failed
[drm:r128_init] *ERROR* Cannot initialize agpgart module.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected an Intel i810 E, but could not find the secondary device.
agpgart: no supported devices found.
/lib/modules/2.2.21/misc/agpgart.o: init_module: Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters
/lib/modules/2.2.21/misc/agpgart.o: insmod agpgart failed

So, fully useless for PCI Cards.

Kind regards,
	Marc


