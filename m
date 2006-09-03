Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWICJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWICJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 05:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWICJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 05:53:37 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:35979 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751140AbWICJxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 05:53:37 -0400
Message-ID: <44FAA61F.9000504@drzeus.cx>
Date: Sun, 03 Sep 2006 11:53:35 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com> <44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org> <44F9EE86.4020500@drzeus.cx> <20060903034836.GB6505@kroah.com>
In-Reply-To: <20060903034836.GB6505@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Sep 02, 2006 at 10:50:14PM +0200, Pierre Ossman wrote:
>   
>>
>> This is a PCI device yes. Which has a number of card readers as
>> separate, hot-pluggable functions. Currently this means it interacts
>> with the block device and MMC subsystems of the kernel. As more drivers
>> pop up, the other card formats will probably get their own subsystems
>> the way MMC has. So there are three issues here:
>>
>>  * Where to put the central module that handles the generic parts of the
>> chip and pulls in the other modules as needed.
>>     
>
> Right now, the drivers/mmc directory has such a driver, the sdhci.c
> file, right?
>
>   

Not quite. sdhci is a vendor-neutral MMC controller driver. What I'm
talking about here is the interface-neutral portion for the Texas
Instruments multi-format card reader.

>>  * If the subfunction modules should be put with the subsystems they
>> connect to or with the main, generic module.
>>     
>
> It all depends on how bit it grows over time.  It is always easy to move
> files around at a later time if you so wish.
>
> For now, is the drivers/mmc/ directory acceptable?  If other card
> formats show up, we can reconsider it at that time.  Is that ok?
>   

Support for MemoryStick isn't that far off in the future, so it would be
preferable to get this right from the start.

Is there no driver in the kernel that already has this design?

Rgds
Pierre


-- 
VGER BF report: U 0.499916
