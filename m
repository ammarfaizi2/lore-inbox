Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315589AbSECIGA>; Fri, 3 May 2002 04:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315590AbSECIF7>; Fri, 3 May 2002 04:05:59 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:59055 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315589AbSECIF5>; Fri, 3 May 2002 04:05:57 -0400
Date: Fri, 3 May 2002 09:45:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Treeve Jelbert <treeve01@pi.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG - linux-2.5.13/arch/i386/kernel - bluesmoke.c
In-Reply-To: <200205030959.52486.treeve01@pi.be>
Message-ID: <Pine.LNX.4.44.0205030944180.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Treeve Jelbert wrote:

> gcc -D__KERNEL__ -I/usr/src/linux-2.5.13/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=athlon    
> -DKBUILD_BASENAME=bluesmoke  -c -o bluesmoke.o bluesmoke.c
> bluesmoke.c: In function `intel_thermal_interrupt':
> bluesmoke.c:36: warning: implicit declaration of function `ack_APIC_irq'
> bluesmoke.c: In function `intel_init_thermal':
> bluesmoke.c:92: warning: implicit declaration of function `apic_read'
> bluesmoke.c:104: warning: implicit declaration of function `apic_write_around'

You need CONFIG_X86_LOCAL_APIC, a proper fix is currently in 2.5-dj 
pending a merge.

Thanks,
	Zwane
-- 
http://function.linuxpower.ca
		

