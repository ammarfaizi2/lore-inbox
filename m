Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWHCPEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWHCPEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWHCPEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:04:54 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:29315 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S932477AbWHCPEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:04:53 -0400
Date: Thu, 3 Aug 2006 17:04:46 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Arnd Hannemann <arnd@arndnet.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
In-Reply-To: <20060803145222.GB14997@kvack.org>
Message-ID: <Pine.LNX.4.64.0608031703330.8443@bizon.gios.gov.pl>
References: <44D1FEB7.2050703@arndnet.de> <20060803142412.GA14997@kvack.org>
 <Pine.LNX.4.64.0608031646110.8443@bizon.gios.gov.pl> <20060803145222.GB14997@kvack.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1612379357-1154617486=:8443"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1612379357-1154617486=:8443
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 3 Aug 2006, Benjamin LaHaise wrote:

> On Thu, Aug 03, 2006 at 04:49:15PM +0200, Krzysztof Oledzki wrote:
>> With 1 GB of RAM full 1GB/3GB (CONFIG_VMSPLIT_3G_OPT) seems to be
>> enough...
>
> Nope, you lose ~128MB of RAM for vmalloc space.

No sure:

Linux version 2.6.17.7 (root@r1) (gcc version 3.4.6) #1 SMP PREEMPT Fri Jul=
 28 18:05:40 CEST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
  BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
  BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
1023MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262080
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 257984 pages, LIFO batch:31
(...)

$ zcat /proc/config.gz |grep VMSPLIT
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=3Dy
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set


Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1612379357-1154617486=:8443--
