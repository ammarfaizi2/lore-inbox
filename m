Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVA0XDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVA0XDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVA0XBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:01:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39398 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261262AbVA0XBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:01:16 -0500
Message-ID: <41F97299.2070909@pobox.com>
Date: Thu, 27 Jan 2005 18:00:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
References: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com>
In-Reply-To: <200501272242.j0RMgoP5016154@falcon30.maxeymade.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Thu, 27 Jan 2005 13:02:48 +0100, Jens Axboe wrote:
> 
>>Hi,
>>
>>For the longest time, only the old PATA drivers supported barrier writes
>>with journalled file systems. This patch adds support for the same type
>>of cache flushing barriers that PATA uses for SCSI, to be utilized with
>>libata. 
> 
> 
> What, if any mechanism supports changing the underlying write cache?  
> 
> That is, assuming this is common across PATA and SCSI drives, and it is 
> possible to turn the cache off on the IDE drives, would switching the 
> cache underneath require completing the inflight IO?

[ignoring your question, but it made me think...]


I am thinking the barrier support should know if the write cache is 
disabled (some datacenters do this), and avoid flushing if so?

	Jeff


