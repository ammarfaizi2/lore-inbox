Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbTK3RY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbTK3RYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:24:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264962AbTK3RWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:22:51 -0500
Message-ID: <3FCA275B.1080904@pobox.com>
Date: Sun, 30 Nov 2003 12:22:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de>
In-Reply-To: <20031130171006.GA10679@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>Well, the constraint we must satisfy is
>>
>>	sector_count % 15 != 1
> 
> 
> 	(sector_count % 15 != 1) && (sector_count != 1)
> 
> to be more precise :)


Thanks for the clarification, I did not know that.

Avoiding sector_count==1 requires additional code :(  Valid requests 
might be a single sector.  With page-based blkdevs requests smaller than 
a page would certainly be infrequent, but are still possible, with bsg 
for example...

	Jeff



