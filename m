Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVBUGg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVBUGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 01:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBUGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 01:36:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:280 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261874AbVBUGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 01:36:25 -0500
Date: Mon, 21 Feb 2005 06:35:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <4218840D.6030203@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> 
    <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> 
    <20050217230342.GA3115@wotan.suse.de> 
    <20050217153031.011f873f.davem@davemloft.net> 
    <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2005, Nick Piggin wrote:
> Andi Kleen wrote:
> > 
> > The problem is just that these walker macros when they
> > do all the lazy walking stuff will be quite complicated.
> > And I don't really want another uaccess.h-like macro mess.
> > 
> > Yes currently they look simple, but that will change.
> 
> But even in that case, it will still be better to have the
> extra complexity once in the macro rather than throughout mm/
> 
> > Open coding is probably the smaller evil.
> > And they're really not changed that often.

My opinion FWIW: I'm all for regularizing the pagetable loops to
work the same way, changing their variables to use the same names,
improving their efficiency; but I do like to see what a loop is up to.

list_for_each and friends are very widely used, they're fine, and I'm
quite glad to have their prefetching hidden away from me; but usually
I groan, grin and bear it, each time someone devises a clever new
for_each macro concealing half the details of some specialist loop.

In a minority?
Hugh
