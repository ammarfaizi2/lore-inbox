Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWATI77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWATI77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWATI77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:59:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750740AbWATI76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:59:58 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, alan@lxorguk.ukuu.org.uk, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060120004456.190f451b.akpm@osdl.org>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <1137664692.8471.21.camel@localhost.localdomain>
	 <20060119155933.GX4213@suse.de>
	 <1137745995.30084.201.camel@localhost.localdomain>
	 <20060120004456.190f451b.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 21:59:54 +1300
Message-Id: <1137747595.30084.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 00:44 -0800, Andrew Morton wrote:
> Oh crap.  The damn thing wraps into column _1_ and gets tangled up with
> ifdef statements, function definitions and other things which _should_ go
> in column one.

It does that only for people with editors which wrap stuff like that
into column 1. Those people (which includes myself on some occasions)
are _used_ to seeing stuff like that in column 1, so it's natural. And
it's text which is of little importance; not something which has much
relevance to the code flow.

> It .looks.  .like.  .crap.  to many other people, and saying random stupid
> wrong things doesn't alter that very simple fact.

No, it looks like crap for _some_ people. And making it look like crap
for _everyone_, which is what your patch does, doesn't alter that fact
either.

It's a simple memcpy(dest, src, len), and the length is almost entirely
superfluous -- we could almost get away with '*dest = *src' here. It
lives on a single line and is messy any other way, and you want to muck
about with it just because there are some poor sods out there for whom
it would look _slightly_ better if you make it look like crap for the
rest of us.

I'm not advocating a blanket removal of the 80-character limit;
important things should always be within 80 columns. But this is fluff;
leave it where it is, please.

-- 
dwmw2

