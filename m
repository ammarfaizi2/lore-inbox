Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUFULEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUFULEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUFULEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:04:21 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:45440 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266188AbUFULEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:04:00 -0400
Date: Mon, 21 Jun 2004 13:04:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Milan Gabor <milan.gabor@utrip.net>
Cc: Peter Cordes <peter@cordes.ca>, ak@suse.de, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] x86-64: double timer interrupts in recent 2.4.x
Message-ID: <20040621110435.GB1721@ucw.cz>
References: <20040616192826.GD14043@cordes.ca> <40D6BC5F.4070200@utrip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D6BC5F.4070200@utrip.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:45:51PM +0200, Milan Gabor wrote:
> Hi!
> 
> I have Suse 9.0 and dual Opteron on MSI K8T Master 2 motherboard.
> I also get  interrupts only on one cpu and my clock is ticking strange, 
> so I have to synchronize it with NTP server frequently.
> 
> This is from my system:
>            CPU0       CPU1
>   0:      30434   16139843    IO-APIC-edge  timer
>   1:        944          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>  14:         30          1    IO-APIC-edge  ide0
>  16:     657371          0   IO-APIC-level  eth0
>  20:     261267          0   IO-APIC-level  libata
> NMI:     694146     873271
> LOC:   16167676   16167576
> ERR:          1
> MIS:          0
> 
> Linux www 2.4.21-226-smp #1 SMP Tue Jun 15 09:14:10 UTC 2004 x86_64 
> x86_64 x86_64 GNU/Linux
> 
> 
> I am also running irq_balance and acpi=off set from grub boot menu.
> Without acpi=off system never boots.
> 
> Is there any solution, so clock will work OK and interrupts will be on 
> both CPUs?
> 
> MIlan

This patch could fix that (replace i386 with x86_64):

http://marc.theaimsgroup.com/?l=linux-kernel&m=108774225111967&w=2


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
