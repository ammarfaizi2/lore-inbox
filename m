Return-Path: <linux-kernel-owner+w=401wt.eu-S1945944AbWLVFS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945944AbWLVFS0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945946AbWLVFS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:18:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41887 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1945944AbWLVFSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:18:25 -0500
Date: Thu, 21 Dec 2006 21:18:12 -0800
From: Paul Jackson <pj@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, y-goto@jp.fujitsu.com,
       npiggin@suse.de
Subject: Re: [BUG][PATCH] fix oom killer kills current every time if there
 is memory-less-node
Message-Id: <20061221211812.4acaede5.pj@sgi.com>
In-Reply-To: <20061222122243.2a46de76.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061222122243.2a46de76.kamezawa.hiroyu@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA-san wrote:
> But there is memory-less-node. contstrained_alloc() should get
> memory_less_node into count.

This patch looks ok to me.

One line in the patch comment seems backward:

  If zone_list includes all nodes, it thinks oom is from mempolicy.

Shouldn't that be:

  If zone_list doesn't include all nodes, it thinks oom is from mempolicy.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
