Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVBFNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVBFNNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVBFNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:11:52 -0500
Received: from news.suse.de ([195.135.220.2]:47514 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261218AbVBFNLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:11:33 -0500
Date: Sun, 6 Feb 2005 14:11:30 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206131130.GJ30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206130650.GA32015@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 01:06:50PM +0000, Christoph Hellwig wrote:
> On Sun, Feb 06, 2005 at 02:01:52PM +0100, Andi Kleen wrote:
> > > correct,
> > > http://lists.ximian.com/archives/public/mono-list/2004-June/021592.html
> > > 
> > > that fixes mono instead
> > 
> > Silent breakage => bad.
> 
> silent breakage for newly compiled buggty and non-portable code.

Executing custom code in mmap is by definition non portable, 
so this argument doesn't make very much sense.

> 
> Still not nice but certainly tolerable.  

I strongly disagree that breaking source level compatibility silently like
this is tolerable.

Especially since it won't even affect most users, so most developers
won't notice it, only the x86-64 users. This makes it extremly
silent for most people.

-Andi
