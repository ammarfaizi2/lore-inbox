Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272607AbTG1G2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272608AbTG1G2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:28:19 -0400
Received: from dm4-157.slc.aros.net ([66.219.220.157]:15489 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272607AbTG1G2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:28:16 -0400
Message-ID: <3F24C610.3020706@aros.net>
Date: Mon, 28 Jul 2003 00:43:28 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: blk_stop_queue/blk_start_queue confusion, problem, or bug???
References: <3F2418D9.1020703@aros.net>
In-Reply-To: <3F2418D9.1020703@aros.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:

> I've been trying to use the blk_start_queue and blk_stop_queue 
> functions in the network block device driver branch I'm working on. 
> The stop works as expected, but the start doesn't. Processes that have 
> tried to read or write to the device (after the queue was stopped) 
> stay blocked in io_schedule instead of getting woken up (after 
> blk_start_queue was called). Do I need to follow the call to 
> blk_start_queue() with a call to wake_up() on the correct wait queues? 
> Why not have that functionality be part of blk_start_queue()? Or was 
> this an oversight/bug? . . .

I'm gonna call this a bug and submit the patch for this since the small 
change I just tried fixed the behavior. Seems like email with subjects 
beginning [PATCH] get a lot more attention so I'm sending the patch in 
another message (titled as such). Hang on... ;-)


