Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWIEUIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWIEUIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWIEUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:08:48 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:53131 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161028AbWIEUIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:08:47 -0400
Message-ID: <44FDD94E.7060701@drzeus.cx>
Date: Tue, 05 Sep 2006 22:08:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com> <44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org> <44F9EE86.4020500@drzeus.cx> <20060903034836.GB6505@kroah.com> <44FAA61F.9000504@drzeus.cx> <20060905191241.GA18427@kroah.com>
In-Reply-To: <20060905191241.GA18427@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Sep 03, 2006 at 11:53:35AM +0200, Pierre Ossman wrote:
>   
>> Is there no driver in the kernel that already has this design?
>>     
>
> Not directly, no.  USB-storage handles a wide range of devices like this
> by virtue of them following the usb storage spec (which is really just
> scsi).
>   

How about this... We put the main driver in drivers/misc, add a Kconfig
for it that isn't visible, put the submodules in their respective
subsystems and set their Kconfigs to select the main module. Does that
sound like a good solution?

Rgds
Pierre

