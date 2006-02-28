Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWB1RL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWB1RL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWB1RL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:11:27 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:21510 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751885AbWB1RL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:11:26 -0500
Message-ID: <440483EC.8070902@cfl.rr.com>
Date: Tue, 28 Feb 2006 12:10:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, pavel@ucw.cz,
       randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com> <20060228114500.GA4057@elf.ucw.cz> <44043B4E.30907@pobox.com> <20060228041817.6fc444d2.akpm@osdl.org>
In-Reply-To: <20060228041817.6fc444d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 17:13:23.0151 (UTC) FILETIME=[47A0C5F0:01C63C8A]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14295.000
X-TM-AS-Result: No--14.400000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Except
> 
> - There's (presently) no way of making all the messages go away for a
>   non-debug build.
> 

I agree, there should be a config option to build the kernel with the 
debug support entirely shut off, though it's a good idea to leave it on 
if you aren't really cramped for space.

> - The code is structured as
> 
> 	if (ata_msg_foo(p))
> 		printk("something");
> 
>   So if we later do
> 
> 	#define ata_msg_foo(p)	0
> 
>   We'll still get copies of "something" in the kernel image (may be fixed
>   in later gcc, dunno).
> 
> - The new debug stuff isn't documented.  One has funble around in the
>   source to work out how to even turn it on.  Can it be altered at runtime?
>   Dunno - the changelogs are risible.  What effect do the various flags
>   have?
> 
>   Having spent (and re-spent) time grovelling through the ALSA source
>   working out how to enable their debug stuff during a maintainer snooze
>   I'd prefer we didn't have to do that with libata as well.
> 

Would you prefer there not be any debug messages at all, rather than 
ones you have to figure out how to turn on and interpret?  Documentation 
is always a good thing, but if you are at least somewhat familiar with 
the code, turning on the debug messages should be easy and rather helpful.

BTW, didn't I see something recently in the kernel about a debug fs? 
Sounded like that was intended for this sort of thing to provide a 
standard interface to configuring fine grained debug message filtering.

