Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVGFUTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVGFUTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGFULr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:11:47 -0400
Received: from graphe.net ([209.204.138.32]:19850 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262287AbVGFTcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:32:03 -0400
Date: Wed, 6 Jul 2005 12:31:57 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050706181349.GN21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507061231310.720@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
 <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061058260.30702@graphe.net>
 <20050706181349.GN21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> > GFP allocs may not do the right thing. If you want to do this then it 
> > may be best to set the memory policy to restrict allocations to the node 
> > on which the device resides.
> 
> They will do the right thing. Under memory pressue on the node 
> it is better to back off than to fail.

Node specific allocs fall back to other nodes and will not fail unless 
there is no memory available.

