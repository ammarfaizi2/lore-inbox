Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWI1Kxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWI1Kxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWI1Kxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:53:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29128 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965290AbWI1Kxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:53:49 -0400
Subject: Re: [PATCH 2.6.18] PCI: Turn pci_fixup_video into generic for
	embedded VGA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: eiichiro.oiwa.nm@hitachi.com
Cc: akpm@osdl.org, tony.luck@intel.com, greg@kroah.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002686U451b55cd@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9002686U451b55cd@hitachi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 12:18:22 +0100
Message-Id: <1159442302.11049.404.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-28 am 13:55 +0900, ysgrifennodd
eiichiro.oiwa.nm@hitachi.com:
> pci_fixup_video turns into generic code because there are many platforms need this fixup
> for embedded VGA as well as x86. The Video BIOS integrates into System BIOS on a machine
> has embedded VGA although embedded VGA generally don't have PCI ROM. As a result,
> embedded VGA need the way that the sysfs rom points to the Video BIOS of System
> RAM (0xC0000). PCI-to-PCI Bridge Architecture specification describes the condition whether
> or not PCI ROM forwards VGA compatible memory address. fixup_video suits this specification.
> Although the Video ROM generally implements in x86 code regardless of platform, some
> application such as X Window System can run this code by dosemu86. Therefore,
> pci_fixup_video should turn into generic code.
> 
> 
> Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>

Acked-by: Alan Cox <alan@redhat.com>

