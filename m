Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUBFNoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBFNoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:44:39 -0500
Received: from intra.cyclades.com ([64.186.161.6]:63209 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265466AbUBFNog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:44:36 -0500
Date: Fri, 6 Feb 2004 11:44:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
In-Reply-To: <200402061735.07726.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.58L.0402061143280.16422@logos.cnet>
References: <200402061735.07726.mhf@linuxmail.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Feb 2004, Michael Frank wrote:

> As with 2.4.24, using the highmem option causes the BUG message.
>
> This is a kernel ex BK without any patches.
>
> Linux version 2.4.25-rc1 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #5 Fri Feb 6 17:27:18 HKT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
>  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
>  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 300MB HIGHMEM available.
> 195MB LOWMEM available.
> On node 0 totalpages: 126960
> zone(0): 4096 pages.
> zone(1): 46064 pages.
> zone(2): 76800 pages.
> BUG: wrong zone alignment, it will crash
> Kernel command line: vga=0xf07 root=/dev/hda4 console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m
> Initializing CPU#0
> Detected 2399.771 MHz processor.
> Console: colour VGA+ 80x60
> Calibrating delay loop... 4784.12 BogoMIPS
> Memory: 498696k/507840k available (1589k kernel code, 8756k reserved, 676k data, 120k init, 307200k highmem)
>
> The kernel seems to experience stability problems.

Michael,

This is totally bogus, you dont have highmem available. Dont use highmem=.

