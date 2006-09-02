Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWIBUuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWIBUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWIBUuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:50:15 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:30347 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751555AbWIBUuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:50:14 -0400
Message-ID: <44F9EE86.4020500@drzeus.cx>
Date: Sat, 02 Sep 2006 22:50:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alex Dubov <oakad@yahoo.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com>	<44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org>
In-Reply-To: <20060902094818.49e5e1b1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 02 Sep 2006 13:15:52 +0200
> Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>   
>> Andrew, we could use some help with how this driver should fit into the
>> kernel tree. The hardware is multi-function, so there will be a couple
>> of drivers, one for every function, and a common part. How has this been
>> organised in the past?
>>
>>     
>
> Greg would be a far better person that I for this.   Is it a PCI device?
>   

It's always difficult to know who to contact when there's an issue that
isn't specific to one single area. And since you are the 2.6 maintainer
I figured it wouldn't be too off base to throw this in your lap. ;)

This is a PCI device yes. Which has a number of card readers as
separate, hot-pluggable functions. Currently this means it interacts
with the block device and MMC subsystems of the kernel. As more drivers
pop up, the other card formats will probably get their own subsystems
the way MMC has. So there are three issues here:

 * Where to put the central module that handles the generic parts of the
chip and pulls in the other modules as needed.

 * If the subfunction modules should be put with the subsystems they
connect to or with the main, generic module.

Rgds
Pierre


-- 
VGER BF report: H 0.055417
