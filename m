Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVHXHwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVHXHwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVHXHwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:52:07 -0400
Received: from mail.dvmed.net ([216.237.124.58]:14480 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750732AbVHXHwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:52:06 -0400
Message-ID: <430C271E.7060006@pobox.com>
Date: Wed, 24 Aug 2005 03:51:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another libata TODO item
References: <430C10E7.9060502@pobox.com> <20050824074116.GF24513@infradead.org>
In-Reply-To: <20050824074116.GF24513@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Aug 24, 2005 at 02:17:11AM -0400, Jeff Garzik wrote:
>>To make libata debugging easier and more fine-grained, we should convert 
>>DPRINTK/VPRINTK calls in libata to code that looks like
>>
>>	if (ata_msg_xxx(ap->msg_enable))
>>		printk(...)
> 
> 
> Would be nice if you could move that one up to the scsi layer and combine
> it with the existing scsi core loglevel handling.


Doubtful.  libata's use of SCSI will become optional, so using SCSI 
logging throughout libata core would be inappropriate.  Block layer 
would be more reasonable.

In any case, I also contine to be skeptical of in-kernel logging subsystems.

	Jeff


