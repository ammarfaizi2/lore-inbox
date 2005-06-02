Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFBCqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFBCqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVFBCqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:46:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32407 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261573AbVFBCqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:46:08 -0400
Message-ID: <429E7304.3060702@sgi.com>
Date: Wed, 01 Jun 2005 22:46:28 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prarit Bhargava <prarit@sgi.com>
CC: scottm@somanetworks.com, Greg K-H <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: more CPCI updates
References: <11176025242587@kroah.com> <429E71CB.3010609@sgi.com>
In-Reply-To: <429E71CB.3010609@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit Bhargava wrote:
> Greg KH wrote:
> 
>> [PATCH] PCI Hotplug: more CPCI updates
> 
> 
>> - Switch to pci_get_slot instead of deprecated pci_find_slot.
>> - A bunch of CodingStyle fixes.
> 
> 
>> -            }
>> +        dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
>> +        if (dev) {
>> +            if (update_adapter_status(slot->hotplug_slot, 1))
>> +                warn("failure to update adapter file");
>> +            if (update_latch_status(slot->hotplug_slot, 1))
>> +                warn("failure to update latch file");
>> +            slot->dev = dev;
>>          }
>>      }
> 
> 
> I don't claim to know the code as well as Scott or Greg does, but I 
> don't see a pci_put_dev for the slot->dev to clean up the usage count?
> 

s/pci_put_dev/pci_dev_put/g

:)

P.
