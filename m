Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTFTSAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTFTSAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:00:23 -0400
Received: from rth.ninka.net ([216.101.162.244]:54659 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263818AbTFTSAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:00:21 -0400
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@suse.de>, clemens-dated-1056963973.bf26@endorphin.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030620105640.10ab68a4.akpm@digeo.com>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel>
	 <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620105640.10ab68a4.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056132854.29696.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jun 2003 11:14:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 10:56, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> >  > again. 
> > 
> >  This will break existing crypto loop installations, making
> >  the existing encrypted image unreadable.
> 
> I think we should just live with that breakage Andi.  You're suggesting
> that we retain compatibility with something which was never merged into the
> kernel.  That is asking too much.

There was effectively no cryptoloop support in the vanilla
kernel.  Andi is totally right here.  We should be compatible
with what people actually used, which were the external cryptoloop
patches.

Nobody, and I mean nobody, has a cryptoloop based upon the IV
selection done in vanilla kernels.

