Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWI1QfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWI1QfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWI1QfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:35:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:55993 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030251AbWI1QfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:35:24 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,231,1157353200"; 
   d="scan'208"; a="138891838:sNHT57678327"
From: Jesse Barnes <jesse.barnes@intel.com>
To: eiichiro.oiwa.nm@hitachi.com
Subject: Re: [PATCH 2.6.18] PCI: Turn pci_fixup_video into generic for embedded VGA
Date: Thu, 28 Sep 2006 09:36:01 -0700
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, tony.luck@intel.com, greg@kroah.com,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <XNM1$9$0$4$$3$3$7$A$9002686U451b55cd@hitachi.com>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002686U451b55cd@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609280936.02098.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 27, 2006 9:55 pm, eiichiro.oiwa.nm@hitachi.com 
wrote:
> pci_fixup_video turns into generic code because there are many platforms
> need this fixup for embedded VGA as well as x86. The Video BIOS
> integrates into System BIOS on a machine has embedded VGA although
> embedded VGA generally don't have PCI ROM. As a result, embedded VGA
> need the way that the sysfs rom points to the Video BIOS of System RAM
> (0xC0000). PCI-to-PCI Bridge Architecture specification describes the
> condition whether or not PCI ROM forwards VGA compatible memory address.
> fixup_video suits this specification. Although the Video ROM generally
> implements in x86 code regardless of platform, some application such as
> X Window System can run this code by dosemu86. Therefore,
> pci_fixup_video should turn into generic code.
>
>
> Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
> ---

Acked-by:  Jesse Barnes <jesse.barnes@intel.com>

Thanks a lot, Eiichiro, this patch has been needed for awhile.

Jesse
