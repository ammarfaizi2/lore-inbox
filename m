Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUCAKSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUCAKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:18:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:28119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261178AbUCAKRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:17:43 -0500
Date: Mon, 1 Mar 2004 02:18:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc1-mm1: vm-kswapd-incremental-min (was Re: MM VM
 patches was: 2.6.3-mm4)
Message-Id: <20040301021855.0c0f994e.akpm@osdl.org>
In-Reply-To: <404307D7.8090102@cyberone.com.au>
References: <20040225185536.57b56716.akpm@osdl.org>
	<4042F38B.8020307@matchmail.com>
	<4042F7E6.1050904@cyberone.com.au>
	<4042FE0D.5030603@cyberone.com.au>
	<404307D7.8090102@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Andrew, I think you had kswapd scanning in the direction opposite the
>  one indicated by your comments. Or maybe I've just confused myself?
> 

Nope, the node_zones[] array is indexed by

#define ZONE_DMA		0
#define ZONE_NORMAL		1
#define ZONE_HIGHMEM		2

Whereas the zonelist.zones[] array goes the other way:
[[[highmem,]normal,]dma,]NULL.

It's a complete dog's breakfast that stuff.  Hard to understand, not very
logical and insufficiently commented.
