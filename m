Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUJGUgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUJGUgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJGUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:36:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38325 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268104AbUJGUap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:30:45 -0400
Message-ID: <4165A766.1040104@pobox.com>
Date: Thu, 07 Oct 2004 16:30:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca> <416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca>
In-Reply-To: <4165A45D.2090200@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> We don't add hooks on the _hope_ that _future_ code will (a) use the 
>> hooks and (b) be GPL'd.
> 
> 
> Sure we do.  All of the time.
> 
> All of the other RAID drivers in the kernel have ioctl() hooks
> for external code to control driver interfaces and settings.
> Except with that kind of interface, we never get an open-source
> version of that external code.

You are missing the key point that an ioctl is _vastly_ differently from 
a kernel interface, from both a legal and technical perspective.

The userland<->kernel interface is a hard "line in the sand" where we 
don't presuppose you are "linking" (as the GPL defines it)


> Given all of the fuss over this core driver (qstor.{ch}),
> there is simply no way the vendor wants to go through it all again
> for their RAID management module.  So sure, it will be GPL and
> given away in source form (website, installation CD, etc..),
> but it won't appear here simply because we're making too hard
> for them to do so.

Hardly.  You're requesting hooks for something that is (a) unreviewed 
and (b) doesn't even exist.  So far as things stand, the need for the 
hooks has not been justified.

Furthermore, it has always been the Linus policy "do what you need, and 
no more."  Adding hooks before they are used violates that credo.


> The exports are needed if we want that component to be open source.
> Otherwise, they'll be replaced by ioctl()s like all of the other
> drivers, and that part of the source code may then never be released.

Fundamentally we do not add kernel interfaces for code that isn't in the 
kernel.

Overall, I don't see why it is so damned difficult to delete the hooks 
then add them back when they _are_ needed.  I would certainly support 
you in that effort.

	Jeff


