Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVKHSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVKHSxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVKHSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:53:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:4274 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030312AbVKHSxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:53:17 -0500
Date: Tue, 8 Nov 2005 10:52:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Roland Dreier <rolandd@cisco.com>
cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
In-Reply-To: <52mzkfrily.fsf@cisco.com>
Message-ID: <Pine.LNX.4.62.0511081049520.30907@schroedinger.engr.sgi.com>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
 <52mzkfrily.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Roland Dreier wrote:

>     > * Replace a constant (4096) with what it represents (PAGE_SIZE)
> 
> This seems dangerous.  I don't pretend to understand the slab code,
> but the current code works on architectures with PAGE_SIZE != 4096.
> Are you sure this change is correct?

Leave the constant. The 4096 is only used for debugging and is a boundary 
at which redzoning and last user accounting is given up.

A large object in terms of this patch is a object greater than 4096 bytes 
not an object greater than PAGE_SIZE. I think the absolute size is 
desired.

Would you CC manfred on all your patches?



