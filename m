Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755763AbWK2VO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763AbWK2VO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758103AbWK2VO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:3505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755763AbWK2VOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:14:54 -0500
Date: Wed, 29 Nov 2006 13:14:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: mel@skynet.ie (Mel Gorman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Break out memory initialisation code from page_alloc.c
 to mem_init.c
Message-Id: <20061129131448.b5761339.akpm@osdl.org>
In-Reply-To: <20061129180045.GA16463@skynet.ie>
References: <20061129180045.GA16463@skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 18:00:47 +0000
mel@skynet.ie (Mel Gorman) wrote:

> page_alloc.c contains a large amount of memory initialisation code which
> obscures the purpose of the file. This patch breaks out the initialisation
> code into a separate file to make page_alloc.c a bit easier to read.
> 
> This is a repost from a long time ago.  At the time it was last posted,
> there was too much churn in page_alloc.c and it was put on the back-burner.
> However, there is still a lot going on in page_alloc.c so the time still
> might not be right.

yeah, it spits a 58k reject already.  There's basically never a good time for this,
but the best time is around 2.6.x-rc1.
