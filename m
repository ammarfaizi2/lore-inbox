Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVF0IVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVF0IVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVF0IVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:21:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:17550 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261956AbVF0IUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:20:47 -0400
Date: Mon, 27 Jun 2005 10:20:46 +0200
From: Andi Kleen <ak@suse.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, flx@namesys.com, zam@namesys.com,
       vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627082046.GC14251@wotan.suse.de>
References: <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost> <20050627072449.GF19550@suse.de> <20050627072832.GA14251@wotan.suse.de> <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:49:19AM +0300, Pekka J Enberg wrote:
> On Mon, 2005-06-27 at 09:28 +0200, Andi Kleen wrote:
> > You can just dump the expression (with #argument). That is what
> > traditional userspace assert did forever.
> > 
> > It won't help for BUG_ON(a || b || c || d || e) but these
> > are bad style anyways and should be avoided.
> 
> Sounds good to me. Jens, would this work for you?

It won't work for me because it'll bloat the kernel .text
considerable. There is a reason why BUG is implemented
like it is. Compare it.

-Andi

