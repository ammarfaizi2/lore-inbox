Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSKRIlN>; Mon, 18 Nov 2002 03:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSKRIlN>; Mon, 18 Nov 2002 03:41:13 -0500
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:6358 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S261624AbSKRIlM>; Mon, 18 Nov 2002 03:41:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.20-rc2, ATYFB, kernel freeze
Date: Mon, 18 Nov 2002 03:47:39 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211180347.39133.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.20-rc2 freezes after the framebuffer initialization message for 
ATYFB... same kernel without it doesn't freeze...

This is an old problem that has been there for several kernels...

Graphics cards:

  Bus  0, device  10, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 
92).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0000fff].

  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti200] (rev 
163).
      IRQ 5.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd4000000 [0xd7ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xd807ffff].


Kernel options:
CONFIG_FB_ATY and CONFIG_FB_ATY_CT and CONFIG_FB_RIVA
Tried disabling RIVA...results are the same...
..yet the NVidia card could be related somehow, because I remember ATYFB 
working when I didn't have the geforce..

SYSRQ has no effect after freeze

