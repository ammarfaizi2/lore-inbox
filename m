Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVE2RhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVE2RhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVE2RhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:37:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39143 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261359AbVE2RhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:37:11 -0400
Message-ID: <4299FDBE.8080806@pobox.com>
Date: Sun, 29 May 2005 13:37:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 00/06] blk: barrier flushing reimplementation
References: <20050529042034.5FF4CF1C@htj.dyndns.org>
In-Reply-To: <20050529042034.5FF4CF1C@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 05_blk_scsi_turn_on_flushing_by_default.patch
> 	: turn on QUEUE_ORDERED_FLUSH by default if ordered tag isn't supported
> 
> 	As flushing can now be used by devices which only support
> 	simple tags, there's no need to use
> 	Scsi_Host_Template->ordered_flush to enable it selectively.
> 	This patch removes ->ordered_flush and enables flushing
> 	implicitly when ordered tag isn't supported.  If the device
> 	doesn't support flushing, it can just return -EOPNOTSUPP for
> 	flush requests.  blk layer will switch to QUEUE_OREDERED_NONE
> 	automatically.


This is rather nice...

	Jeff


