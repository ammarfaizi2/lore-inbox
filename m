Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVG3Dxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVG3Dxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 23:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVG3Dxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 23:53:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54995 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262815AbVG3Dwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 23:52:53 -0400
Message-ID: <42EAF987.7020607@pobox.com>
Date: Fri, 29 Jul 2005 23:52:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@dodo.com.au
CC: "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com>
In-Reply-To: <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Grant Coady wrote: > On Fri, 29 Jul 2005 18:21:05
	-0400, Jeff Garzik <jgarzik@pobox.com> wrote: > >>[speaking to the
	audience] I wouldn't mind if someone did a pass >>through pci_ids.h and
	removed all the constants that are not being used. > > > Only these
	seem not referenced by source: > PCI_CLASS_SYSTEM_PCI_HOTPLUG >
	PCI_DEVICE_ID_CYRIX_PCI_MASTER > PCI_DEVICE_ID_HP_PCI_LBA >
	PCI_DEVICE_ID_NP_PCI_FDDI > PCI_DEVICE_ID_UPCI_RM3_4PORT >
	PCI_DEVICE_ID_UPCI_RM3_8PORT > > Source macros refer to: > BROOKTREE
	sound/pci/bt87x.c > YAMAHA sound/oss/ymfpci.c > > 6 from 2329 entries
	hardly worth it? [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Fri, 29 Jul 2005 18:21:05 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>[speaking to the audience]  I wouldn't mind if someone did a pass 
>>through pci_ids.h and removed all the constants that are not being used. 
> 
> 
> Only these seem not referenced by source:
> PCI_CLASS_SYSTEM_PCI_HOTPLUG
> PCI_DEVICE_ID_CYRIX_PCI_MASTER
> PCI_DEVICE_ID_HP_PCI_LBA
> PCI_DEVICE_ID_NP_PCI_FDDI
> PCI_DEVICE_ID_UPCI_RM3_4PORT
> PCI_DEVICE_ID_UPCI_RM3_8PORT
> 
> Source macros refer to:
>   BROOKTREE	sound/pci/bt87x.c
>   YAMAHA	sound/oss/ymfpci.c
> 
> 6 from 2329 entries hardly worth it?

However you did your search, you did it wrong.  The very first two 
entries I tried had zero uses:

[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_22
./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_22   0x27e0
[jgarzik@pretzel linux-2.6]$ grepsrc ICH7_23
./include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_ICH7_23   0x27e2
[jgarzik@pretzel linux-2.6]$

