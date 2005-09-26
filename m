Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVIZSA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVIZSA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVIZSA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:00:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932449AbVIZSA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:00:28 -0400
Date: Mon, 26 Sep 2005 11:00:11 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alok Kataria <alokk@calsoftinc.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <Pine.LNX.4.63.0509251937510.24430@alok.intranet.calsoftinc.com>
Message-ID: <Pine.LNX.4.62.0509261058340.3650@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0509251937510.24430@alok.intranet.calsoftinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Alok Kataria wrote:

> As pointed by Christoph,  In kmalloc_node we are cheking if, the allocation is
> for the
> same node when interrupts are "on", this may lead to an allocation on another
> node than intended.
> This patch just shifts the check for the current node in __cache_alloc_node
> when interrupts
> are disabled.

Alokk, could you verify that this patch works?

Petr, could you check that this patch fixes your issue? I am a bit 
skeptical. I do not think we have found the real problem yet. We need to 
have some way to reproduce the problem if it still persists after applying 
Alokk's patch.


