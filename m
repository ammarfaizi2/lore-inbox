Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbULHH3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbULHH3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULHH3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:29:15 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:29066 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262058AbULHH2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:28:18 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Xen VMM patch set - take 4
Date: Wed, 08 Dec 2004 07:28:16 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've sync'ed up with the head of the Xen repository, and also brought
the patch up to 2.6.10-rc3

The patches are pretty much identical to the take 3 set, which people
seemed to be pretty happy with.

To get a working arch xen system you need the following set of
patches:

 1. add ptep_establish_new to make va available
 2. return code for arch_free_page
 3. runtime disable of VT console
 4. HAS_ARCH_DEV_MEM enables Xen to use own /dev/mem definition
 5. split free_irq into teardown_irq
 6. alloc_skb_from_cache	(already accepted by Dave Miller)

The actual new architecture, arch xen, is too big to post to the list,
so here's a link:
 http://www.cl.cam.ac.uk/netos/xen/downloads/arch-xen.patch

Likewise for the virtual block, network, and console drivers:
 http://www.cl.cam.ac.uk/netos/xen/downloads/drivers-xen.patch

Arch xen will be maintained by myself, Keir Fraser, Christian Limpach
and Steve hand. 

Cheers,
Ian
