Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVKHS7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVKHS7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbVKHS7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:59:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:741 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030306AbVKHS7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:59:52 -0500
Date: Tue, 8 Nov 2005 10:59:46 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
In-Reply-To: <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.62.0511081058580.30907@schroedinger.engr.sgi.com>
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com>
 <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Pekka J Enberg wrote:

> On Mon, 7 Nov 2005, Matthew Dobson wrote:
> > I found three functions in slab.c that have only 1 caller (kmem_getpages,
> > alloc_slabmgmt, and set_slab_attr), so let's inline them.
> 
> Why? They aren't on the hot path and I don't see how this is an 
> improvement...

It avoids the call/return sequences so it may decrease code size a bit and 
allow the compiler (if its up to the task) to do more CSE optimizations.

