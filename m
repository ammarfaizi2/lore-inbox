Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVAFBiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVAFBiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVAFBiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:38:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:10981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262700AbVAFBiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:38:14 -0500
Date: Wed, 5 Jan 2005 17:37:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: riel@redhat.com, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-Id: <20050105173739.2d91deb3.akpm@osdl.org>
In-Reply-To: <41DC955D.9020505@yahoo.com.au>
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>
	<20050105020859.3192a298.akpm@osdl.org>
	<20050105180651.GD4597@dualathlon.random>
	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>
	<20050105174934.GC15739@logos.cnet>
	<20050105134457.03aca488.akpm@osdl.org>
	<20050105203217.GB17265@logos.cnet>
	<41DC7D86.8050609@yahoo.com.au>
	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>
	<41DC955D.9020505@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Rik van Riel wrote:
> > On Thu, 6 Jan 2005, Nick Piggin wrote:
> > 
> >> I think what Andrea is worried about is that blk_congestion_wait is 
> >> fairly vague, and can be a source of instability in the scanning 
> >> implementation.
> > 
> > 
> > The recent OOM kill problem has been happening:
> > 1) with cache pressure on lowmem only, due to a block device write
> > 2) with no block congestion at all
> > 3) with pretty much all pageable lowmme pages in writeback state
> > 
> > It appears the VM has trouble dealing with the situation where
> > there is no block congestion to wait on...
> > 
> 
> Try, together with your nr_scanned patch, to replace blk_congestion_wait
> with io_schedule_timeout.

Why?  Is the nr_scanned fix insufficient?
