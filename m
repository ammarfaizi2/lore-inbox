Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVGGOOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGGOOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGGOOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:14:33 -0400
Received: from ns.suse.de ([195.135.220.2]:57307 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261589AbVGGON5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:13:57 -0400
Date: Thu, 7 Jul 2005 16:13:56 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
Message-ID: <20050707141356.GC21330@wotan.suse.de>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net> <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061232040.720@graphe.net> <20050707103918.GV21330@wotan.suse.de> <Pine.LNX.4.62.0507070642370.22915@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507070642370.22915@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Only kmalloc_node will make a reasonable attempt to locate the memory on 
> > > a specific node.
> > 
> > You forgot __get_free_pages.
> 
> The slab allocator uses alloc_pages and alloc_pages_node

alloc_pages is NUMA aware. __get_free_pages is just a wrapper for it.

-Andi
