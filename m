Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755310AbWKVQLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbWKVQLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbWKVQLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:11:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:29712 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1755317AbWKVQLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:11:33 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,448,1157353200"; 
   d="scan'208"; a="167824550:sNHT1772431367"
Message-ID: <456476B0.70705@intel.com>
Date: Wed, 22 Nov 2006 08:11:28 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Arjan van de Ven <arjan@infradead.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 4/5] e1000 : Make Intel e1000 driver legacy I/O port free
References: <4564050C.70607@jp.fujitsu.com> <1164185809.31358.714.camel@laptopd505.fenrus.org> <20061122135423.GV18567@parisc-linux.org>
In-Reply-To: <20061122135423.GV18567@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Nov 22, 2006 at 09:56:49AM +0100, Arjan van de Ven wrote:
>> On Wed, 2006-11-22 at 17:06 +0900, Hidetoshi Seto wrote:
>>>  static struct pci_device_id e1000_pci_tbl[] = {
>>> +	INTEL_E1000_ETHERNET_DEVICE(0x1004, 0),
>>> +	INTEL_E1000_ETHERNET_DEVICE(0x1008, E1000_USE_IOPORT),
>> Hi,
>>
>> this has the unfortunate effect that it's now a lot harder to add PCI
>> ID's to this driver at runtime via sysfs ;(
> 
> It does?  Normally you get 0 passed in that field, so you'll just not
> get io ports enabled ...
> 
> Need to set use_driver_data to get non-0 passed in that field.

I think we want to condense the USE_IOPORT flag together with the other hardware feature 
flags, as suggested by Jeff Garzik. This would save some headroom and leave the pci 
device id table as it is.

Cheers,

Auke
