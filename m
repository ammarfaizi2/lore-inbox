Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVJ2KAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVJ2KAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVJ2KAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:00:15 -0400
Received: from mail.suse.de ([195.135.220.2]:17618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750911AbVJ2KAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:00:14 -0400
From: Andi Kleen <ak@suse.de>
To: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Date: Sat, 29 Oct 2005 12:01:05 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <p73vezhtkpy.fsf@verdi.suse.de> <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
In-Reply-To: <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510291201.06613.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 00:06, Janne M O Heikkinen wrote:
> On Sat, 28 Oct 2005, Andi Kleen wrote:
> > Janne M O Heikkinen <jmoheikk@cc.helsinki.fi> writes:
> >> With CONFIG_K8_NUMA I get the following right after boot:
> >> PANIC: early exception rip ffffffff8023429f error 0 cr2 0
> >> PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd023
> >
> > Did earlier kernels work? Please post full log with earlyprintk=vga
> > or earlyprintk=serial,ttySx,baud
>
> 2.6.13.4 works just fine, this is what I got with earlyprintk=vga:
>
> Loading K-2.6.14
> Bootdata ok (command line is auto BOOT_IMAGE=K-2.6.14 ro root=901
> resume=/dev/md0 selinux=0 splash=verbose console=tty0 earlyprintk=vga)
> Linux version 2.6.14-smp (jamse@linux) (gcc version 4.0.2) #3 SMP
> PREEMPT Fri Oct 28 20:49:34 EEST 2005one.
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
> BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
> BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
> BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
> BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
> SRAT: PXM 1 -> APIC 1 -> CPU 1 -> Node 1
> SRAT: Node 0 PXM 0 100000-7fffffff
> SRAT: Node 1 PXM 1 80000000-bfffffff
> SRAT: Node 1 PXM 1 80000000-13fffffff
> SRAT: Node 0 PXM 0 0-7fffffff
> Bootmem setup node 0 0000000000000000-000000007fffffff
> PANIC: early exception rip ffffffff8023429f error 0 cr2 0
> PANIC: early exception rip ffffffff8011893a error 0 cr2 ffffffffff5fd02

And it boots with numa=noacpi ? 

-Andi
