Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268682AbTCCRbl>; Mon, 3 Mar 2003 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268683AbTCCRbl>; Mon, 3 Mar 2003 12:31:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59849 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268682AbTCCRbk>; Mon, 3 Mar 2003 12:31:40 -0500
Date: Mon, 03 Mar 2003 09:42:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Walrond <andrew@walrond.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dmesg: Use a PAE enabled kernel
Message-ID: <29570000.1046713325@[10.10.2.4]>
In-Reply-To: <3E6381B9.4090708@walrond.org>
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]> <3E6381B9.4090708@walrond.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Warning only 4GB will be used.
> Use a PAE enabled kernel.
> 3200MB HIGHMEM available.
> 896MB LOWMEM available.
> 
> So you are saying that not all the 4Gb of ram will get mapped/used (specifically, everything not marked 'usable') ?
> 
> Can you quantify the performance degredation of a PAE enabled kernel?

Depends on your workload ... there's only one way to be sure, benchmark it.
If you're doing heavy page replacment / setup / teardown, it'll be more
expensive. As Alan has pointed out, you're loosing a quarter of your RAM ;-)

M.

