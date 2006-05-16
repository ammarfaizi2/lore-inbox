Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWEPEWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWEPEWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 00:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWEPEWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 00:22:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30650 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751260AbWEPEWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 00:22:11 -0400
Subject: Re: [PATCH] slab: Fix kmem_cache_destroy() on NUMA
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@sgi.com>
Cc: Roland Dreier <rdreier@cisco.com>, Linus Torvalds <torvalds@osdl.org>,
       "akpm@osdl.org Linux Kernel Mailing List" 
	<linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Or Gerlitz <ogerlitz@voltaire.com>
In-Reply-To: <Pine.LNX.4.64.0605151446340.835@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
	 <Pine.LNX.4.44.0605141306240.29880-100000@zuben>
	 <adaves7rv0j.fsf_-_@cisco.com>
	 <Pine.LNX.4.64.0605151446340.835@schroedinger.engr.sgi.com>
Date: Tue, 16 May 2006 07:22:07 +0300
Message-Id: <1147753327.11271.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006, Roland Dreier wrote:
> > This patch fixes this by having drain_cpu_caches() do 
> > drain_alien_cache() on every node before it does drain_array() on the 
> > nodes' shared array_caches.

On Mon, 2006-05-15 at 14:47 -0700, Christoph Lameter wrote:
> Correct. That is the fix that I suggested earlier. The alien caches needs 
> to be drained first.

Yeah, looks good to me too. Thanks Roland!

			Pekka

