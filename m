Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUD1X6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUD1X6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUD1X6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:58:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:38583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262008AbUD1X6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:58:41 -0400
Date: Wed, 28 Apr 2004 17:01:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: brettspamacct@fastclick.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428170106.122fd94e.akpm@osdl.org>
In-Reply-To: <409021D3.4060305@fastclick.com>
References: <409021D3.4060305@fastclick.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> wrote:
>
> I attached sar, slabinfo and /proc/meminfo data on the 2.6.5 machine.  I 
> reproduce this behavior by simply untarring a 260meg file on a 
> production server, the machine becomes sluggish as it swaps to disk.

I see no swapout from the info which you sent.

A `vmstat 1' trace would be more useful.

> Is there a way to limit the cache so this machine, which has 1 gigabyte of 
> memory, doesn't dip into swap?

Decrease /proc/sys/vm/swappiness?

Swapout is good.  It frees up unused memory.  I run my desktop machines at
swappiness=100.

