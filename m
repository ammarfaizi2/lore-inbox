Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbTCYQAj>; Tue, 25 Mar 2003 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbTCYQAj>; Tue, 25 Mar 2003 11:00:39 -0500
Received: from ma-northadams1a-382.bur.adelphia.net ([24.52.175.126]:34966
	"EHLO ma-northadams1a-382.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S262690AbTCYQAh>; Tue, 25 Mar 2003 11:00:37 -0500
Date: Tue, 25 Mar 2003 11:11:39 -0500
From: Eric Buddington <eric@ma-northadams1a-382.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66: ehci-hcd: loss of streaming while burning CDs
Message-ID: <20030325111139.B17703@ma-northadams1a-382.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.66 compiled for 386, running on a K6/250.

I am having trouble burning CDs using an external CD burner (NEC
NR-7800, with "burn-proof", in an external IDE-to-USB case) at 16x and
8x. My USB card is the following:
	
 Bus  0, device   8, function  0:
    USB Controller: NEC Corporation USB (rev 65).
      IRQ 12.
      Master Capable.  Latency=32.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xe8002000 [0xe8002fff]

I can burn CDs reliably from a USB-1.0 card, also at a nominal 16x
(really much slower, of course). With my USB-2.0 card at 16x, about 1
in 10 works; the rest give the following error:

2003-03-25:10:44:43-[valid=0] Info fld=0, Current sense key: 0x05: Illegal Request
2003-03-25:10:44:43-Raw sense data: 0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 
2003-03-25:10:44:43-0x00 0x00 0x21 0x02 0x00 0x00 
2003-03-25:10:44:43-plus...: Driver_status=0x08 (DRIVER_SENSE,SUGGEST_OK) 
2003-03-25:10:44:43:ERROR: Write data failed.
2003-03-25:10:44:43:ERROR: Writing failed - buffer under run?
2003-03-25:10:44:43:ERROR: Simulation failed.

Is there any other debug info that would be useful?

-Eric
