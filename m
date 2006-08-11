Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWHKPrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWHKPrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHKPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:47:15 -0400
Received: from rtr.ca ([64.26.128.89]:8423 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932169AbWHKPrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:47:14 -0400
Message-ID: <44DCA67B.5070400@rtr.ca>
Date: Fri, 11 Aug 2006 11:47:07 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain> <44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>
In-Reply-To: <44DACE9F.3090909@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> This will also allow time for things like "udev" to perhaps think about
>> an option to someday provide /dev/hd* symlinks for PATA devices when
>> libata is used instead of IDE (?).  That might be a possible migration
>> path in the far future.
> 
> Unfortunately a symlink won't work because of compatibility issues. 
> /dev/hd supports more partitions, and a different set of ioctls.

Anything that depends upon the extra partitions is going to have a 
difficult time regardless of whether or not they edit /etc/fstab
to change "hda" into "sda" etc..

And libata already has sufficient ioctl compatibility for nearly all
purposes with the old drivers/ide stuff.  Yes, there are some more
esoteric ioctls that I once implemented in drivers/ide that do not
exist for libata, and nobody will miss them.

Cheers
