Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTJOAgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 20:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJOAgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 20:36:12 -0400
Received: from dyn-ctb-210-9-246-230.webone.com.au ([210.9.246.230]:31492 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261648AbTJOAgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 20:36:11 -0400
Message-ID: <3F8C966F.5080109@cyberone.com.au>
Date: Wed, 15 Oct 2003 10:35:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
References: <20031014105514.GH765@holomorphy.com>
In-Reply-To: <20031014105514.GH765@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>So I tried mem=16m on my laptop (stinkpad T21). I made the following
>potentially useless observations:
>

snip


>
>inode_cache               840K           840K     100.00%   
>dentry_cache              746K           753K      99.07%   
>ext3_inode_cache          591K           592K      99.84%   
>size-4096                 504K           504K     100.00%   
>size-512                  203K           204K      99.75%   
>size-2048                 182K           204K      89.22%   
>pgd                       188K           188K     100.00%   
>task_struct               100K           108K      92.86%   
>vm_area_struct             93K           101K      92.28%   
>blkdev_requests           101K           101K     100.00%   
>

Hmm blkdev_requests looks big. 4 struct requests are allocated for every 
queue,
which totals about 600 bytes. What does /sys/block and the 
blkdev_requests line
from /proc/slabinfo look like?


