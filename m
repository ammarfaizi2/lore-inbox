Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752457AbWCQE6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbWCQE6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCQE6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:58:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:10123 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752457AbWCQE6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:58:46 -0500
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>
	 <20060316163728.06f49c00.akpm@osdl.org>
	 <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 15:58:09 +1100
Message-Id: <1142571490.9022.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Quite frankly, I don't think nopfn() is a good interface. It's only usable 
> for one single thing, so trying to claim that it's a generic VM op is 
> really not valid. If (and that's a big if) we need this interface, we 
> should just do it inside mm/memory.c instead of playing games as if it was 
> generic.

Or just use sparsemem and create struct pages for your hw :) we do that
for SPUs on Cell, works like a charm.

Ben.


