Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWCBUCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCBUCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCBUCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:02:01 -0500
Received: from mail.dvmed.net ([216.237.124.58]:19145 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751230AbWCBUCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:02:00 -0500
Message-ID: <44074F2B.4020100@pobox.com>
Date: Thu, 02 Mar 2006 15:01:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302180025.GC28895@flint.arm.linux.org.uk> <44073593.60703@pobox.com> <20060302191305.GF28895@flint.arm.linux.org.uk>
In-Reply-To: <20060302191305.GF28895@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Nevertheless, my basic point that the no_ioport solution only addresses
> one problem area, while being far too late for the other methods still
> stands.

Agreed.

FWIW, as a PCI driver writer I've always wanted a one-call-does-it-all 
interface, where you pass in a struct that describes
* what BARs to map (pci_iomap/ioremap, pci_request_regions)
* irq handler (request_irq)
* enable bus mastering, MWI (pci_set_master, pci_set_mwi)

to collapse the billion-and-one pci_xxx calls into a single one that 
replaces pci_enable_device(dev) with pci_up(dev, &info).

	Jeff


