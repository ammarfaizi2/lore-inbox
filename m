Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVBXF7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVBXF7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVBXF7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:59:44 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:37292 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261824AbVBXF7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:59:42 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
	 <20050217230342.GA3115@wotan.suse.de>
	 <20050217153031.011f873f.davem@davemloft.net>
	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>
	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	 <421B0163.3050802@yahoo.com.au>
	 <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
	 <421D1737.1050501@yahoo.com.au>
	 <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 16:59:37 +1100
Message-Id: <1109224777.5177.33.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 05:12 +0000, Hugh Dickins wrote:
> On Thu, 24 Feb 2005, Nick Piggin wrote:

> > OK after sleeping on it, I'm warming to your way.
> > 
> > I don't think it makes something like David's modifications any
> > easier, but mine didn't go a long way to that end either. And
> > being a more incremental approach gives us more room to move in
> > future (for example, maybe toward something that really *will*
> > accommodate the bitmap walking code nicely).
> 
> I'll take a quick look at David's today.
> Just so long as we don't make them harder.
> 

No, I think we may want to move to something better abstracted:
it makes things sufficiently complex that you wouldn't want to
have it open coded everywhere.

But no, you're not making it harder than the present situation.

> > So I'd be pretty happy for you to queue this up with Andrew for
> > 2.6.12. Anyone else?
> 
> Oh, okay, thanks.  You weren't very happy with p??_limit(addr, end),
> and good naming is important to me.  I didn't care for your tentative
> p??_span or p??_span_end.  Would p??_end be better?  p??_enda would
> be fun for one of them...
> 

pud_addr_end?



http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
