Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbUK3CIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUK3CIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUK3CHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:07:41 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:9432 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261932AbUK3CDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:03:55 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Xen VMM patch set - take 3
Date: Tue, 30 Nov 2004 02:03:45 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We didn't get much feedback from take 2, so hopefully we're
converging on something that's acceptable. The only major
difference between this set and the previous is the way we handle
the /dev/mem changes. I think the new approach is rather cleaner.

To get a working arch xen system you'll need the following set of
patches:

 1. add ptep_establish_new to make va available
 2. return code for arch_free_page
 3. runtime disable of VT console
 4. HAS_ARCH_DEV_MEM enables Xen to use own /dev/mem definition
 5. split free_irq into teardown_irq
 6. alloc_skb_from_cache (already accepted by Dave Miller)
 7. bug fix: handle frag'ed skbs in icmp_filter (already accepted by Dave Miller)

The actual new architecture, arch xen, is too big to post to the list,
so here's a link:
 8. http://www.cl.cam.ac.uk/netos/xen/downloads/arch-xen.patch

Likewise for the virtual block, network, and console drivers:
 9. http://www.cl.cam.ac.uk/netos/xen/downloads/drivers-xen.patch


Arch xen will be maintained by myself, Keir Fraser, Christian Limpach
and Steve Hand. 

Cheers,
Ian

