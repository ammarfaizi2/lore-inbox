Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSGIJmQ>; Tue, 9 Jul 2002 05:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317346AbSGIJmQ>; Tue, 9 Jul 2002 05:42:16 -0400
Received: from 62-190-201-188.pdu.pipex.net ([62.190.201.188]:52741 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316989AbSGIJmO>; Tue, 9 Jul 2002 05:42:14 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207090949.KAA00888@darkstar.example.net>
Subject: Re: 2.5.25 IDE: PDC20268 interrupt problem
To: fvdpol@home.nl (Frank van de Pol)
Date: Tue, 9 Jul 2002 10:49:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020709075410.GA23574@idefix.fvdpol.home.nl> from "Frank van de Pol" at Jul 09, 2002 09:54:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You're not alone with this problem, there is a thread "ATAPI + cdwriter problem", that is somewhat related - I originally blamed the controller, (also a Promise one), but then thought it was something else.  Now I'm not so sure.  You might want to look at that thread, though.

John.

> Hi folks,
> 
> when booting 2.5.25 it seems that every operation to my Promise Ultra100TX2
> controller attached disks ends up in having lost interrupts (lost interrupt;
> pdc202xx: Primary channel reset etc. etc.). Even the partition table
> detection of the disks takes forever (but it does get detected though).
> 
> I've 2 of those U100TX2 controllers in my machine. I can't tell where in the
> 2.5 series this problem was introduced since there was some breakage for the
> MD drivers in the late 2.5 series. 2.4 kernels run fine though. 
> 
> I noticed that kernel 2.5.25 binds all 4 Promise IDE controllers to IRQ 16,
> while 2.4.18 uses a different IRQ for every board. 
> 
> 
> 2.4.18: (works fine)
> ide2 at 0xa800-0xa807,0xac02 on irq 17
> ide3 at 0xb000-0xb007,0xb402 on irq 17
> ide4 at 0xbc00-0xbc07,0xc002 on irq 18
> ide5 at 0xc400-0xc407,0xc802 on irq 18
> 
> 
> 2.5.25: (lost interrupts)
> ide2 at 0xa800-0xa807,0xac02 on irq 16
> ide3 at 0xb000-0xb007,0xb402 on irq 16
> ide4 at 0xbc00-0xbc07,0xc002 on irq 16
> ide5 at 0xc400-0xc407,0xc802 on irq 16
> 
> 
> Any clues?
> 
> Frank.
> 
> -- 
> +---- --- -- -  -   -    - 
> | Frank van de Pol                  -o)    A-L-S-A
> | FvdPol@home.nl                    /\\  Sounds good!
> | http://www.alsa-project.org      _\_v
> | Linux - Why use Windows if we have doors available?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

