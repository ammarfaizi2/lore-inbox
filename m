Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWBXXUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWBXXUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbWBXXUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:20:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932641AbWBXXUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:20:12 -0500
Date: Fri, 24 Feb 2006 15:22:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Problems for IBM x440 in 2.6.16-rc4-mm1 and -mm2 (PCI?)
Message-Id: <20060224152216.2ed60306.akpm@osdl.org>
In-Reply-To: <43FF2D38.2020602@mbligh.org>
References: <43FF2D38.2020602@mbligh.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> OK, mainline is fine, but -mm won't boot:
> 
> mainline boot log:
> 
> http://test.kernel.org/23745/debug/console.log
> (-git7)
> 
> -mm boot log:
> http://test.kernel.org/23752/debug/console.log
> 
> It seems to find no PCI devices at all, and I note that when they first
> seem to diverge, we get:
> 
> PCI: Probing PCI hardware
> PCI quirk: region 0440-044f claimed by vt82c686 SMB
> PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 39
> PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 16
> PCI->APIC IRQ transform: 0000:00:05.2[D] -> IRQ 47
> PCI->APIC IRQ transform: 0000:00:05.3[D] -> IRQ 47
> Setting up standard PCI resources
> 
> Instead of:
> 
> PCI: Probing PCI hardware
> PCI quirk: region 0440-044f claimed by vt82c686 SMB
> PCI: Discovered peer bus 01
> PCI: Discovered peer bus 02
> PCI: Discovered peer bus 05
> PCI: Discovered peer bus 07

Does reverting gregkh-pci-pci-device-ensure-sysdata-initialised.patch help,
or does it just take you back to the bug which that fixed?
