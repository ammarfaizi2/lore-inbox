Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBWEtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBWEtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVBWEtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:49:43 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:689 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261156AbVBWEtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:49:41 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hugh Dickins <hugh@veritas.com>, ak@suse.de, benh@kernel.crashing.org,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050222203115.49f79f42.davem@davemloft.net>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
	 <20050217230342.GA3115@wotan.suse.de>
	 <20050217153031.011f873f.davem@davemloft.net>
	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>
	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	 <421B0163.3050802@yahoo.com.au>
	 <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
	 <20050222203115.49f79f42.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 15:49:30 +1100
Message-Id: <1109134170.5177.9.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 20:31 -0800, David S. Miller wrote:
> On Wed, 23 Feb 2005 02:06:28 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I've not seen Dave's bitmap walking functions (for clearing?),
> > would they fit in better with my way?
> 

Hugh: I'll have more of a look through your patch when I get
some time... to be honest I'm not too worried either way, so
long as one or the other gets in.

Very trivial point, but I'm not sure that I like the name
p?d_limit... maybe p?d_span or _span_end... hmm, they're not
really pleasing either.

You _are_ repeating a bit of mindless loop accounting in every
page table walk, and it isn't completely clear to me that it is
giving you much more flexibility (than for_each_*). But my loops
_are_ a bit contorted.

> This is what Nick is referring to:
> 

[snip]

> It's easy to toy with the sparc64 optimization on other platforms,
> just add the necessary hacks to pmd_set and pgd_set, allocation
> of pmd and pgd tables

David: just an implementation detail that I had meant to bring
up earlier - would it feel like less of a hack to put these in
pmd_populate and pgd_populate?

Nick




