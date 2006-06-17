Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWFQOs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWFQOs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 10:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWFQOs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 10:48:28 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:61859 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751642AbWFQOs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 10:48:27 -0400
Message-ID: <44941632.4050703@myri.com>
Date: Sat, 17 Jun 2006 10:48:18 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, discuss@x86-64.org
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport
 capabilities
References: <4493709A.7050603@myri.com> <20060617062840.GD31645@kroah.com>	<4493AB39.7010409@myri.com> <p73ver0p4vp.fsf@verdi.suse.de>
In-Reply-To: <p73ver0p4vp.fsf@verdi.suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Brice Goglin <brice@myri.com> writes:
>   
>> Or we could enable MSI by default on PCI-E chipsets and disable by
>> default on non-PCI-E (ie we whitelist non-PCI-E only) ? PCI-E chipsets
>> seem to support MSI pretty well.
>>     
>
> It looks like at least Serverworks HT1000 has trouble with MSI
> too, but it's PCI-Express. But I guess those can be black listed
>   

IIRC, HT1000 is the southbridge part of the HT2000 chipset. We have been
told that MSI works on this chipset. And from what we've seen/tested, it
is true. The problem is that MSI is often disabled by the BIOS. My
hypertransport MSI capability quirk should check it right.

Brice

