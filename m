Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTGKQHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTGKQHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:07:15 -0400
Received: from dm1-21.slc.aros.net ([66.219.220.21]:55494 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264095AbTGKQHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:07:14 -0400
Message-ID: <3F0EE41A.5060004@aros.net>
Date: Fri, 11 Jul 2003 10:21:46 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mbligh@aracnet.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 895] New: Kernel panic at boot: EIP is at kobject_get
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the request_queue_t kobj field not being intialized by 
drivers/block/ll_rw_blk.c blk_init_queue() bug. Either blk_init_queue() 
needs to be fixed to initialize the new q->kobj field (my 
recommendation) or the memset() hack to nbd needs to be merged in. 
Please CC me at least on any further correspondence regarding this so I 
have a better chance of catching these emails. Thanks.

