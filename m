Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbUDOQzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUDOQzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:55:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9256 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264347AbUDOQzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:55:42 -0400
Date: Thu, 15 Apr 2004 17:55:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <41380000.1082043649@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0404151752210.9569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Martin J. Bligh wrote:
> > 
> > Any ideas how we might handle latency from vmtruncate (and
> > try_to_unmap) if using prio_tree with i_shared_lock spinlock?
> 
> I've been thinking about that. My rough plan is to go wild, naked and lockless.
> If we arrange things in the correct order, new entries onto the list would

It's quite easy if there's a list - though I'm not that eager to go wild,
naked and lockless with you!  But what if there's a prio_tree?

Hugh

