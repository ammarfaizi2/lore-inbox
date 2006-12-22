Return-Path: <linux-kernel-owner+w=401wt.eu-S1945945AbWLVFVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbWLVFVa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945946AbWLVFVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:21:30 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60287 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945945AbWLVFVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:21:30 -0500
Date: Fri, 22 Dec 2006 14:24:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, y-goto@jp.fujitsu.com,
       npiggin@suse.de
Subject: Re: [BUG][PATCH] fix oom killer kills current every time if there
 is memory-less-node
Message-Id: <20061222142448.14836b59.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061221211812.4acaede5.pj@sgi.com>
References: <20061222122243.2a46de76.kamezawa.hiroyu@jp.fujitsu.com>
	<20061221211812.4acaede5.pj@sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 21:18:12 -0800
Paul Jackson <pj@sgi.com> wrote:

> KAMEZAWA-san wrote:
> > But there is memory-less-node. contstrained_alloc() should get
> > memory_less_node into count.
> 
> This patch looks ok to me.
> 
> One line in the patch comment seems backward:
> 
>   If zone_list includes all nodes, it thinks oom is from mempolicy.
> 
> Shouldn't that be:
> 
>   If zone_list doesn't include all nodes, it thinks oom is from mempolicy.
> 
Ah, yes. (>_<, Thank you.

-Kame

