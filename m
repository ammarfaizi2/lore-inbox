Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWALQJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWALQJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWALQJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:09:25 -0500
Received: from rtr.ca ([64.26.128.89]:65417 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030457AbWALQJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:09:24 -0500
Message-ID: <43C67F20.30300@rtr.ca>
Date: Thu, 12 Jan 2006 11:09:04 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: fix possible queue stall in blk_do_ordered
References: <20060112152949.GA9855@htj.dyndns.org>
In-Reply-To: <20060112152949.GA9855@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Previously, if a fs request which was being drained failed and got
> requeued, blk_do_ordered() didn't allow it to be reissued, which
> causes queue stall.  This patch makes blk_do_ordered() use the
> sequence of each request to determine whether a request can be issued
> or not.  This fixes the bug and simplifies code.

What kernel(s) is this against?  The patch seems to fail on 2.6.15.

Thanks
