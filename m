Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWI2P6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWI2P6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWI2P6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 11:58:09 -0400
Received: from graphe.net ([209.204.138.32]:39066 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932305AbWI2P6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 11:58:07 -0400
Date: Fri, 29 Sep 2006 08:58:02 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: reduce numa text size
In-Reply-To: <Pine.LNX.4.58.0609291505060.6223@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0609290856130.12408@graphe.net>
References: <Pine.LNX.4.58.0609291505060.6223@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Pekka J Enberg wrote:

> This patch reduces NUMA text size of mm/slab.o a little on x86 by using
> a local variable to store the result of numa_node_id().

Looks okay.

The convention for this local variable is to use simply "node" 
not "thisnode". See other optimizations like that in the slab 
allocator.

