Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262520AbREUWgS>; Mon, 21 May 2001 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbREUWgJ>; Mon, 21 May 2001 18:36:09 -0400
Received: from [192.187.140.129] ([192.187.140.129]:51329 "EHLO paracel.com")
	by vger.kernel.org with ESMTP id <S262520AbREUWgC>;
	Mon, 21 May 2001 18:36:02 -0400
From: "Christophe Beaumont" <christophe@paracel.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: HUGE contiguous mem space with 2.4
Date: Mon, 21 May 2001 15:39:32 -0700
Message-ID: <NFBBINOGHMOOBMPNBAHKMEFLCAAA.christophe@paracel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I am facing an odd problem here. I have an application here
that requires a HUGE physically contiguous memory area to 
be locked (yes, I have hardware DMA'ing in and out of that
area, over the PCI bus). HUGE being like one Gig (could be
more if needed...)
I am trying to use the mem=1024M option at boot time (yes,
the box has 2 Gigs of RAM) and then ioremap() from within 
my module. There I have a couple of issues:
 - if I use high_memory as is, I cannot remap any area 
(high_memory=f800:0000 ???)
 - if I use high_memory thru virt_to_phys, I can then remap...
up to 64 Megs (maybe a little more, but for sure less than
128 Megs) (virt_to_phys(high_mem)=3800:0000)

I tried with other values (like mem=250M 512M 1536M) and could
NOT remap anything close to the whole amount of "reserved" memory
(best case being with mem=256M I can remap 512M out of 1.75Gigs)

I guess I am missing a point somewhere.... or have totally 
been "ignoring" some doc somewhere (alessandro could be the man
for this one thing *-) )

[system is a dual P3 with 2 gigs of RAM, a 2.4.3 kernel with SMP
turned on... and the nice option for 4Gigs of RAM... would the
64Gig option help me??? just wondering there...]

Any pointer, advise, help, hint... laugh at the stupid thing I 
have forgotten is more than welcome..

tia

Chris.
