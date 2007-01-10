Return-Path: <linux-kernel-owner+w=401wt.eu-S932688AbXAJCyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbXAJCyN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 21:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbXAJCyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 21:54:13 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16037 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688AbXAJCyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 21:54:12 -0500
Date: Tue, 09 Jan 2007 20:53:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI BIOS Bug messages
In-reply-to: <fa.Qx7aDKdds0Jcb7QVB09RiurSBYo@ifi.uio.no>
To: Vasudevan S <savasude@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <45A45545.2040002@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.Qx7aDKdds0Jcb7QVB09RiurSBYo@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasudevan S wrote:
> I run Fedora Core 6 on the 'compaq nc6320' laptop. I am using the
> '2.6.19.1' kernel.
> 
> While booting the kernel, I noticed the following error message:
> 
> PCI: BIOS Bug: MCFG area at f8000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> 
> After some search, I commented out the 'e820_all_mapped()' check in
> the 'pci_mmcfg_init()' function. I no longer see this message and MMCONFIG
> method seems to be used now.
> 
> Is this the right thing to do?

Maybe on that box you can get away with it, but I believe the purpose of 
the check is to weed out BIOSes that have totally broken MCFG tables. I 
think there is some work going on to be able to check and/or bash the 
chipset registers manually on various chipsets to reduce our reliance on 
the BIOS getting this right..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

