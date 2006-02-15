Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030611AbWBODSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbWBODSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWBODSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:18:39 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38104 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030611AbWBODSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:18:37 -0500
Message-ID: <43F29D02.1090606@jp.fujitsu.com>
Date: Wed, 15 Feb 2006 12:16:18 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 0/4] PCI legacy I/O port free driver
References: <43F172BA.1020405@jp.fujitsu.com> <p7364ni475t.fsf@verdi.suse.de>
In-Reply-To: <p7364ni475t.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> writes:
> 
> 
>>I encountered a problem that some PCI devices don't work on my system
>>which have huge number of PCI devices.
> 
> 
> Is that a large IA64 system?
> 

Yes. My IA64 system can have maximum 128 PCI slots, but
currently many of devices on those slots don't work...

> [...]
> 
> The basic concept looks good to me, but I would suggest you use
> the Linux bitmap functions (DECLARE_BITMAP(), set_bit, test_bit etc.)
> instead of open coding all that.
> 
> And for the e1000 change - instead of adding a big switch with
> magic numbers that will likely bitrot it's better to use 
> the driver_data field in pci_device_id for such device specific flags.
> 

I see.
I will try to fix my patches based on your suggestion.

Thanks,
Kenji Kaneshige

