Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTE0WYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTE0WYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:24:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64641
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264305AbTE0WYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:24:18 -0400
Date: Wed, 28 May 2003 00:38:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2003@gmx.net,
       manish@storadinc.com, christian.klose@freenet.de, wli@holomorphy.com
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527223800.GC1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva> <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random> <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva> <20030527200339.GI3767@dualathlon.random> <Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva> <20030527202520.GN3767@dualathlon.random> <20030527151830.40b3d281.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527151830.40b3d281.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:18:30PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > However the last numbers from Randy showed my tree going faster than 2.5
> > with bonnie and tiotest so I think we don't need to worry and I would
> > probably not fix it in a different way in 2.4 even if it would mean a 1%
> > degradation.
> 
> That could be because -aa quadruples the size of the VM readahead window.
> 
> Changes such as that should be removed when assessing the performance
> impact of this particular patch.

I understand that was a generic benchmark against 2.5, not meant to
evaluate the effect of the fixed readahead (see the name of the patch
"readahead-got-broken-somehwere"). I don't see any good reason why
should Randy cripple down my tree before benchmarking against 2.5? if
something it's ok to apply some of my patches to 2.5, that's great, the
other way around not IMHO.

Andrea
