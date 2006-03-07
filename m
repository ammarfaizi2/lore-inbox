Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWCGMRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWCGMRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWCGMRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:17:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbWCGMRa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:17:30 -0500
Date: Tue, 7 Mar 2006 04:15:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?TU9LUkVKX18=?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5 huge memory detection regression
Message-Id: <20060307041532.3ef45392.akpm@osdl.org>
In-Reply-To: <440D6581.9080000@ribosome.natur.cuni.cz>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>
>   I just tested 2.6.16-rc5 kernel on MSI 9136 dual Xeon server 
>  motherboard with 16 GB of memory and the kernel detects only 8 GB of 
>  RAM instead. 2.6.15 kernel detected properly 16 GB. I haven't tested 
>  any kernel revisions in between these two, but could if you point me 
>  in a specific direction. Attaching diff(1) output of dmesg(1) outputs.
>  Please Cc: me in replies. Thanks!
>  Martin
> 
> 
> [boot-2.6.15_to_16-rc5.diff  text/plain (12156 bytes)]

The diff is useful.

>  --- tmp/boot-2.6.15.txt	2006-03-07 11:45:48.015509048 +0100
>  +++ tmp/boot-2.6.16-rc5.txt	2006-03-07 11:45:48.029506920 +0100
>  @@ -1,4 +1,4 @@
>  -Linux version 2.6.15 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 20:20:06 MET 2006
>  +Linux version 2.6.16-rc5 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 19:58:24 MET 2006
>   BIOS-provided physical RAM map:
>    BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
>    BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
>  @@ -12,16 +12,16 @@
>    BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>    BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
>    BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
>  - BIOS-e820: 0000000100000000 - 0000000430000000 (usable)
>  -16256MB HIGHMEM available.
>  + BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
>  +8064MB HIGHMEM available.

These numbers are what the BIOS is telling the kernel about your machine. 
Was the BIOS changed?

If not, you might need to wiggle those DIMMs or something.

