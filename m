Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313619AbSDPPnZ>; Tue, 16 Apr 2002 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313632AbSDPPnY>; Tue, 16 Apr 2002 11:43:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313619AbSDPPnX>; Tue, 16 Apr 2002 11:43:23 -0400
Subject: Re: [PATCH] fix ips driver compile problems
To: haveblue@us.ibm.com (Dave Hansen)
Date: Tue, 16 Apr 2002 17:01:02 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3CBC3DB5.7020709@us.ibm.com> from "Dave Hansen" at Apr 16, 2002 08:05:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVOB-0000Ed-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    This patch has been floating inside IBM for a bit, but it appears 
> that no one passed it back up to you, yet.  I don't know who wrote it, 
> but it applies to 2.5.8 and the ServeRAID driver works just fine with it 
> applied.  Without it, the driver fails to compile.

>   
> -#error Please convert me to Documentation/DMA-mapping.txt

See Documentation/DMA-mapping.txt

> -   scb->scb_busaddr = VIRT_TO_BUS(scb);
> +   scb->scb_busaddr = virt_to_phys(scb);

Nope.. thats not what Documentation/DMA-mapping.txt says

It needs updating to use the pci DMA API. That also conveniently should
put you close to having it work cross platform
