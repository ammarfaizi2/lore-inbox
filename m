Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUITVB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUITVB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUITVB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:01:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:36052 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267345AbUITVBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:01:24 -0400
Date: Mon, 20 Sep 2004 22:57:53 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, akpm@osdl.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available cmpxchg on i386
Message-ID: <20040920205752.GH4242@wotan.suse.de>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0409200844460.3633@schroedinger.engr.sgi.com> <200409202043.00580.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:49:20PM -0700, Christoph Lameter wrote:
> On Mon, 20 Sep 2004, Denis Vlasenko wrote:
> 
> > I think it shouldn't be this way.
> >
> > OTOH for !CONFIG_386 case it makes perfect sense to have it inlined.
> 
> Would the following revised patch be acceptable?

You would need an EXPORT_SYMBOL at least. But to be honest your
original patch was much simpler and nicer and cmpxchg is not called
that often that it really matters. I would just ignore Denis' 
suggestion and stay with the old patch.

-Andi
