Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUAGVVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUAGVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:21:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266245AbUAGVVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:21:10 -0500
Message-ID: <3FFC782B.1060307@pobox.com>
Date: Wed, 07 Jan 2004 16:20:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: "Miscellaneous" bus for the driver model?
References: <Pine.LNX.4.44L0.0401071054220.850-100000@ida.rowland.org> <20040107173345.GD31177@kroah.com> <20040107211656.D18708@flint.arm.linux.org.uk>
In-Reply-To: <20040107211656.D18708@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Jan 07, 2004 at 09:33:45AM -0800, Greg KH wrote:
> 
>>On Wed, Jan 07, 2004 at 11:00:16AM -0500, Alan Stern wrote:
>>
>>>Would it make sense for the driver model core to add a "miscellaneous" or 
>>>"other" bus, intended for devices or drivers that are one-of-a-kind or 
>>>otherwise non-standard?  Kind of similar to the platform bus but meant 
>>>for new things, not part of a legacy or other system/architecture-specific 
>>>base?
>>
>>That's what the "legacy" bus is for.  There's a patch floating around
>>that renames that bus to "platform" to remove any connotation that
>>"legacy" might occur.
> 
> 
> Can we get this patch merged ASAP please?  It should really have gone
> in before 2.6 so we don't have this change during a stable kernel series.


It's already in :)

	Jeff



ChangeSet@1.1474.51.99, 2003-12-29 21:54:21-08:00, akpm@osdl.org
   [PATCH] Rename legacy_bus to platform_bus

   From: Jeff Garzik <jgarzik@pobox.com>

   I've seen this patch floating around.  Not sure the origin, but it's
   surfaced on lkml and also when I was poking around handhelds.org CVS for
   iPAQ patches:  on non-PCs, particularly system-on-chip devices but not
   just there, you have a custom "platform bus" that is the root of pretty
   much all other devices and buses.

   It's something I wanted to make sure people didn't forget; to make sure
   the legacy_bus didn't get "legacied out of existence."  ;-)


