Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVFUSlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVFUSlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVFUSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:41:12 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:27861 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262209AbVFUSlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:41:08 -0400
Message-ID: <42B85F41.3030009@pantasys.com>
Date: Tue, 21 Jun 2005 11:41:05 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Hodle, Brian" <BHodle@harcroschem.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: FW: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
In-Reply-To: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2005 18:38:23.0750 (UTC) FILETIME=[67B96A60:01C57690]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Hodle, Brian wrote:
> 	I am experiencing exactly the same problem. I am using an ASUS
> K8N-DL MB with the x86_64 kernel. My PCIX devices are not allocated
> correctly. I tried using the  'pci=routeirq' option to no avail. Disabling
> ACPI in the BIOS does not help the situation either. X will not use my PCIX
> for GLX since none of the  extra txture memory has been allocated! Anyone
> have any ideas?

well my system is using PCIe instead so it's a little different. It 
seems that the PCIe fixups are enough to get the BAR regions assigned 
correctly. prior to loading the nvidia driver the BARs are listed as 
disabled in lspci -vvx, but after loading the BARs are not disabled and 
I am able run X on both GPUs fine. I haven't tried running any OpenGL 
type tests yet on the system.

pci=routeirq is a red herring, this is about the interrupts and 
shouldn't affect the bar allocation.

it might be useful for you to post a dmesg with PCI_DEBUG enabled and 
specify which kernel version you are using. My system only worked with 
the most recent 2.6.12 (but i think that's due to some of the pci 
express changes and some of the bridge handling since our system is a 
little unique...)

peter
