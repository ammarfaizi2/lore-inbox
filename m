Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271733AbTG2NdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271734AbTG2NdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:33:23 -0400
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:37608 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id S271733AbTG2NdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:33:15 -0400
Date: Tue, 29 Jul 2003 15:33:09 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Rob Shortt <rob@infointeractive.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA errors - 2.4.22-pre8 - SiS730 - WD800JB
Message-ID: <20030729153309.A25792@bouton.inet6-interne.fr>
Mail-Followup-To: Rob Shortt <rob@infointeractive.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F266B99.1040507@infointeractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F266B99.1040507@infointeractive.com>; from rob@infointeractive.com on mar, jui 29, 2003 at 09:42:01 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, jui 29, 2003 at 09:42:01 -0300, Rob Shortt wrote:
> 
> Hello all,
> 

Hi,

> I have had some mysterious errors that aren't totally fatal in 
> themselves but have led me to reset my machine whenever it happens.  I 
> decided to investigate further by using a seperate console to examine 
> things when it happens.
> 
> My system:
> 
> ECS K7SEM w/ Athlon XP 2100+

This is a SiS based mainboard.
SiS APIC support was still buggy last time I checked.

> hda: dma_timer_expiry: dma status == 0x21
> hda: error waiting for DMA
> hda: dma timeout retry: status=0xd0 { Busy }
> 
> hda: DMA disabled
> ide0: reset timed-out, status=0xd0
> hda: status timeout: status=0xd0 { Busy }
> [...]

Can be related to my hint above.

> 
> Dmesg output after bootup and my .config are below:
> 
> Linux version 2.4.22-pre8 (root@freevo) (gcc version 2.95.4 20011002 
> (Debian prerelease)) #2 Sat Jul 26 13:13:03 ADT 2003
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>   BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
>   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 512MB LOWMEM available.
> On node 0 totalpages: 131072
> zone(0): 4096 pages.
> zone(1): 126976 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/hda1 ro
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

Argh ?

> [...]

Usually disabling local APIC support solves this (sometimes with nasty
side-effects like huge perf drops or lost peripheral support).

You can quickly try to pass "noapic" to the kernel and report.

There are SiS APIC patches floating around, try looking in the mailing list
archives, there was a similar problem reported not long ago (for a SiS based
laptop).

Best regards,

LB.
