Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSGIHvf>; Tue, 9 Jul 2002 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGIHve>; Tue, 9 Jul 2002 03:51:34 -0400
Received: from mail3.home.nl ([213.51.129.227]:43467 "EHLO mail3.home.nl")
	by vger.kernel.org with ESMTP id <S317330AbSGIHvd>;
	Tue, 9 Jul 2002 03:51:33 -0400
From: Frank van de Pol <fvdpol@home.nl>
Date: Tue, 9 Jul 2002 09:54:10 +0200
To: linux-kernel@vger.kernel.org
Cc: dalecki@evision-ventures.com
Subject: 2.5.25 IDE: PDC20268 interrupt problem
Message-ID: <20020709075410.GA23574@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

when booting 2.5.25 it seems that every operation to my Promise Ultra100TX2
controller attached disks ends up in having lost interrupts (lost interrupt;
pdc202xx: Primary channel reset etc. etc.). Even the partition table
detection of the disks takes forever (but it does get detected though).

I've 2 of those U100TX2 controllers in my machine. I can't tell where in the
2.5 series this problem was introduced since there was some breakage for the
MD drivers in the late 2.5 series. 2.4 kernels run fine though. 

I noticed that kernel 2.5.25 binds all 4 Promise IDE controllers to IRQ 16,
while 2.4.18 uses a different IRQ for every board. 


2.4.18: (works fine)
ide2 at 0xa800-0xa807,0xac02 on irq 17
ide3 at 0xb000-0xb007,0xb402 on irq 17
ide4 at 0xbc00-0xbc07,0xc002 on irq 18
ide5 at 0xc400-0xc407,0xc802 on irq 18


2.5.25: (lost interrupts)
ide2 at 0xa800-0xa807,0xac02 on irq 16
ide3 at 0xb000-0xb007,0xb402 on irq 16
ide4 at 0xbc00-0xbc07,0xc002 on irq 16
ide5 at 0xc400-0xc407,0xc802 on irq 16


Any clues?

Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
