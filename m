Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbTDAAdd>; Mon, 31 Mar 2003 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTDAAdd>; Mon, 31 Mar 2003 19:33:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13443
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S261949AbTDAAdc>;
	Mon, 31 Mar 2003 19:33:32 -0500
Date: Tue, 1 Apr 2003 02:44:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030401004453.GB12718@x30.random>
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331183506.GC11026@x30.random> <20030331194117.A27859@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331194117.A27859@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 07:41:17PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 31, 2003 at 08:35:06PM +0200, Andrea Arcangeli wrote:
> > About you not caring anymore about the mem_map array size, that still
> > matters on the embedded usage, infact rmap on the embedded usage is the
> > biggest waste there, normally they don't even have swap so if something
> > you should use the rmap provided for truncate, rather than wasting
> > memory in the mem_map array.
> 
> We have CONFIG_SWAP for that in 2.5..

that's useless for the case I mentioned, you definitely still need to
unpage all private and shared mappings, and you can use the rmap
provided by truncate for that. Infact I don't think CONFIG_SWAP is
useful at all.

Andrea
