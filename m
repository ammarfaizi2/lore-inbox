Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269160AbTCDDMO>; Mon, 3 Mar 2003 22:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269161AbTCDDMO>; Mon, 3 Mar 2003 22:12:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58380 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269160AbTCDDMN>; Mon, 3 Mar 2003 22:12:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dmesg: Use a PAE enabled kernel
Date: 3 Mar 2003 19:22:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4165h$f0f$1@cesium.transmeta.com>
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]> <3E6381B9.4090708@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3E6381B9.4090708@walrond.org>
By author:    Andrew Walrond <andrew@walrond.org>
In newsgroup: linux.dev.kernel
>
> The dump looks like this:
> 
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
>   BIOS-e820: 00000000bfffa000 - 00000000bffff000 (ACPI data)
>   BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
>   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>   BIOS-e820: 0000000100000000 - 0000000140000000 (usable)  
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	       This memory lives above the 4GB mark.

> Warning only 4GB will be used.
> Use a PAE enabled kernel.
> 3200MB HIGHMEM available.
> 896MB LOWMEM available.
> 
> So you are saying that not all the 4Gb of ram will get mapped/used 
> (specifically, everything not marked 'usable') ?

Basically, your motherboard only allows 3 GB below the 4 GB boundary;
the rest ends up above.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
