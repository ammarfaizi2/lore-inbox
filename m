Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWHYKr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWHYKr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWHYKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:47:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7330 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751438AbWHYKr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:47:56 -0400
Date: Fri, 25 Aug 2006 12:47:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Philip R. Auld" <pauld@egenera.com>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-ID: <20060825104738.GA8538@elf.ucw.cz>
References: <20060813215853.0ed0e973.akpm@osdl.org> <44E3E964.8010602@google.com> <20060816225726.3622cab1.akpm@osdl.org> <44E5015D.80606@google.com> <20060817230556.7d16498e.akpm@osdl.org> <44E62F7F.7010901@google.com> <20060818153455.2a3f2bcb.akpm@osdl.org> <44E650C1.80608@google.com> <20060818194435.25bacee0.akpm@osdl.org> <20060821132717.GD26589@vienna.egenera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821132717.GD26589@vienna.egenera.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - We expect that the lots-of-dirty-anon-memory-over-swap-over-network
> >   scenario might still cause deadlocks.  
> > 
> >   I assert that this can be solved by putting swap on local disks.  Peter
> >   asserts that this isn't acceptable due to disk unreliability.  I point
> >   out that local disk reliability can be increased via MD, all goes quiet.
> 
> Putting swap on local disks really messes up the concept of stateless 
> servers. I suppose you can do some sort of swap encryption, but
> otherwise you need to scrub the swap partition on boot if you
> re-purpose the hardware. You also then need to do hardware
> configuration to make sure the local disks are all setup the 
> same way across all server platforms so the common images can 
> boot. 

We should really encrypt swap with random key generated at boot, for
all the machine. I believe it is possible (with some non-trivial
setup) today, but it would be nice to do it automagically.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
