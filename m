Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUIJMWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUIJMWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIJMWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:22:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57569 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266143AbUIJMWH (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:22:07 -0400
Date: Fri, 10 Sep 2004 13:21:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nikita Danilov <nikita@clusterfs.com>
cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: 2.6.9-rc1: page_referenced_one() CPU consumption
In-Reply-To: <Pine.LNX.4.44.0409101304570.16614-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409101315520.16623-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Hugh Dickins wrote:
> 
> I'm quite content to go back to a trylock in page_referenced_one - and
> in try_to_unmap_one?  But yours is the first report of an issue there,
> so I'm inclined to wait for more reports (which should come flooding in
> now you mention it!), and input from those with a better grasp than I
> of how vmscan pans out in practice (Andrew, Nick, Con spring to mind).

Just want to add, that there'd be little point in changing that back
to a trylock, if vmscan ends up cycling hopelessly around a larger
loop - though if the larger loop is more preemptible, that's a plus.

Hugh

