Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWAUFVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWAUFVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 00:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWAUFVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 00:21:50 -0500
Received: from tornado.reub.net ([202.89.145.182]:46013 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161273AbWAUFVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 00:21:49 -0500
Message-ID: <43D1C4E9.7030901@reub.net>
Date: Sat, 21 Jan 2006 18:21:45 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060119)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-acpi@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/01/2006 4:46 p.m., Alan Stern wrote:
> On Mon, 16 Jan 2006, Reuben Farrelly wrote:
> 
>>> From the information presented here, it looks like -mm1 correctly routes
>>> the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
>>> -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
>>> it an ACPI problem.
>> Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
>> frequently on the SATA ports on later -mm releases?
>> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)
> 
> I doubt they are at all related.  In the USB problem the resource is there 
> but ACPI is routing it wrongly.  In the SATA problem the resource isn't 
> there to begin with.
> 
> But then I know almost nothing about ACPI, so I could be wrong...
> 
> Alan Stern

Some good news.  I think it's fixed in 2.6.16-rc1-mm2.  In fact a whole boatload 
of problems I was having are fixed in this -mm release, including a nasty libata 
oops that seemed to have a few people scratching their heads.

I've now done in excess of 20 reboots with this code and haven't had either 
problem show up at all.

So for now I'll keep a record of things for a bit longer, but I guess I've 
reason to be fairly confident that both this USB/IRQ problem and my ATA/IRQ 
problem are now fixed.

It does make me wonder if the ACPI update in rc1-mm2 fixed it, and was actually 
the cause of most of my problems......it would be nice to know for sure.

Thanks,
Reuben

