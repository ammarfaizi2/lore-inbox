Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTJPKqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJPKqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:46:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262824AbTJPKqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:46:24 -0400
Message-ID: <3F8E76F2.10908@pobox.com>
Date: Thu, 16 Oct 2003 06:46:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
References: <20031013140858.GU1107@suse.de> <20031013223911.GB14152@merlin.emma.line.org> <3F8B4048.2010007@pobox.com> <20031016103653.GN1128@suse.de>
In-Reply-To: <20031016103653.GN1128@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Oct 13 2003, Jeff Garzik wrote:
> 
>>Matthias Andree wrote:
>>
>>>On Mon, 13 Oct 2003, Jens Axboe wrote:
>>>
>>>
>>>
>>>>Forward ported and tested today (with the dummy ext3 patch included),
>>>>works for me. Some todo's left, but I thought I'd send it out to gauge
>>>>interest. TODO:
>>>>
>>>>- Detect write cache setting and only issue SYNC_CACHE if write cache is
>>>>enabled (not a biggy, all drives ship with it enabled)
>>>
>>>
>>>Yup, and I disable it on all drives at boot time at the latest.
>>>
>>>Is there a status document that lists
>>>
>>>- what SCSI drivers support write barriers
>>> (I'm interested in sym53c8xx_2 if that matters)
>>>
>>>- what IDE drivers support write barriers
>>> (VIA for AMD and Intel for PII/PIII/P4 chip sets here)
>>
>>The device is the entity that does, or does not, support flush-cache... 
>> All IDE chipsets support flush-cache... it's just another IDE command.
> 
> 
> Well drivers need to support it, too. IDE is supported, and that covers
> all devices that support it. It's not implemented on SCSI at all right
> now, that's coming up.

I do not see the need for write barrier support in 
drivers/ide/pci/{via82cxxx,piix,}.c, which is the question the original 
poster was asking.

Low-level chipset drivers should _not_ need to support it, the subsystem 
can do that.

	Jeff



