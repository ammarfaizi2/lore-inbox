Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVIWA22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVIWA22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVIWA21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:28:27 -0400
Received: from dvhart.com ([64.146.134.43]:6537 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751235AbVIWA21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:28:27 -0400
Date: Thu, 22 Sep 2005 17:28:26 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <95320000.1127435305@[10.10.2.4]>
In-Reply-To: <77240000.1127420050@[10.10.2.4]>
References: <20050921222839.76c53ba1.akpm@osdl.org><64900000.1127415577@[10.10.2.4]> <20050922125219.7ea04930.akpm@osdl.org> <77240000.1127420050@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Thursday, September 22, 2005 13:14:11 -0700):

>>> Plus it panics on boot on Power-4 LPAR
>>> 
>>> Memory: 30962716k/31457280k available (4308k kernel code, 494564k reserved, 1112k data, 253k bss, 420k init)
>>> Mount-cache hash table entries: 256
>>> softlockup thread 0 started up.
>>> Processor 1 found.
>>> softlockup thread 1 started up.
>>> Processor 2 found.
>>> softlockup thread 2 started up.
>>> Processor 3 found.
>>> Brought up 4 CPUs
>>> softlockup thread 3 started up.
>>> NET: Registered protocol family 16
>>> PCI: Probing PCI hardware
>>> IOMMU table initialized, virtual merging disabled
>>> PCI_DMA: iommu_table_setparms: /pci@3fffde0a000/pci@2,2 has missing tce entries !
>>> Kernel panic - not syncing: iommu_init_table: Can't allocate 1729382256943765922 bytes
>>> 
>>>  <7>RTAS: event: 3, Type: Internal Device Failure, Severity: 5
>>> ibm,os-term call failed -1
>> 
>> There are ppc64 IOMMU changes in Linus's tree...
> 
> Thanks. will retest with just linus.patch to confirm

Yeah, is broken there too. Borkage in mainline! ;-)

http://test.kernel.org/13316/debug/console.log

if someone wants to look ...

M.

