Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFQNb6>; Mon, 17 Jun 2002 09:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSFQNb5>; Mon, 17 Jun 2002 09:31:57 -0400
Received: from sys-209.inet6.fr ([62.210.110.209]:54656 "EHLO ns1.inet6.fr")
	by vger.kernel.org with ESMTP id <S313416AbSFQNb4>;
	Mon, 17 Jun 2002 09:31:56 -0400
Message-ID: <3D0DE4CC.9010901@inet6.fr>
Date: Mon, 17 Jun 2002 15:31:56 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 hardlock w/ hdparm
References: <Pine.LNX.4.44.0206150948140.30400-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>Hi Lionel, Martin,
>2.5.20, hdparm + IDE deadlocks on my testbox
>  
>

I don't follow 2.5 dev (yet). I merely follow Andre's work on 2.4 and 
code a new chipset capabilities detection code in order to support newer 
 chipsets.
Is the v0.13 driver driver already forward ported to 2.5 by somebody ?
If there's a need (some 2.5 developpers needing a more uptodate driver 
and uncomfortable with forward porting IDE chipset drivers), I'll do it...

>kernel:Linux version 2.5.20+prempt (zwane@montezuma.mastecende.com) (gcc version
>2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #24 SMP Wed Jun 5 21:48:07 SAST 2002
>
>ata subsys:
>ATA/ATAPI device driver v7.0.0
>ATA: PCI bus speed 33.3MHz
>ATA: Silicon Integrated Systems [SiS] 5513 [IDE], PCI slot 00:00.1
>PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using pci=biosirq.
>ATA: chipset rev.: 208
>ATA: non-legacy mode: IRQ probe delayed
>SiS620
>

Unless the SiS620 is not compatable with the 630 IDE support spec or 
affected by some bugs I corrected for PIO mode timings (unlikely as they 
were unnoticed for a quiet long time) since sis5513.c v0.11 this should 
not be an IDE chipset problem.

>[...] btw Martin you seem to like pain so get ready for when i whip out the old 
>Quantum mavericks, 486 (SiS) and Opti621 card ;)
>  
>

Hum, 486 SiS chipsets might bring pain to me also...
I've received several bugreports for old SiS IDE chipset (ie pre ATA66) 
that I couldn't solve without disabling the SiS driver or passing 
"ide=nodma". I've triple-checked the specs and couldn't see the problem.

>Thanks,
>	Zwane Mwaikambo
>  
>
LB

