Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWB1T2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWB1T2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWB1T2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:28:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:18324 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932456AbWB1T2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:28:02 -0500
Message-ID: <4404A438.8050409@pobox.com>
Date: Tue, 28 Feb 2006 14:27:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pavel@ucw.cz, randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>	<20060228114500.GA4057@elf.ucw.cz>	<44043B4E.30907@pobox.com>	<20060228041817.6fc444d2.akpm@osdl.org>	<440442A4.2090201@pobox.com> <20060228103519.20f9b277.akpm@osdl.org>
In-Reply-To: <20060228103519.20f9b277.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>>
>>>
>>>>Fine-grained 
>>>>message selection allows one to turn on only the messages needed, and 
>>>>only for the controller desired.
>>>
>>>
>>>Except
>>>
>>>- There's (presently) no way of making all the messages go away for a
>>>  non-debug build.
>>
>>They aren't supposed to go away.
>>
> 
> 
> It is legitimate to elect to waste memory on every machine so as to make
> the system more easily debugged by remote maintainers.  But that's an
> unusual choice in the kernel context.

Not unusual, as I said, its done in a ton of net drivers.

That said, I suppose its OK to do

	#define ata_msg_foo() 0

for wacky embedded situations.  But the default will be enabled for all 
users, not just debug kernels.


>>>- The new debug stuff isn't documented.  One has funble around in the
>>>  source to work out how to even turn it on.  Can it be altered at runtime?
>>>  Dunno - the changelogs are risible.  What effect do the various flags
>>>  have?
>>
>>The model has always been documented:
>>http://www.scyld.com/pipermail/vortex/2001-November/001426.html
>>(scroll down a tad)
> 
> 
> That's useless.

Not useless at all:  It documents the model that is being implemented 
quite well.  libata will use the same method of bitmasks, same method of 
increasing verbosity as set by debug level, same method of masking the 
more verbose messages by default, but always compiling the messages into 
the driver.  Its highly similar.

	Jeff


