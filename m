Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWC2Eek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWC2Eek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWC2Eek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:34:40 -0500
Received: from koto.vergenet.net ([210.128.90.7]:40908 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750815AbWC2Eej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:34:39 -0500
Date: Wed, 29 Mar 2006 13:12:08 +0900
From: Horms <horms@verge.net.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: optimize constant-size kzalloc calls
Message-ID: <20060329041206.GC16353@verge.net.au>
References: <1142868958.11159.0.camel@localhost> <20060329015745.GA29301@verge.net.au> <20060328.180605.96459770.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328.180605.96459770.davem@davemloft.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 06:06:05PM -0800, David S. Miller wrote:
> From: Horms <horms@verge.net.au>
> Date: Wed, 29 Mar 2006 10:57:46 +0900
> 
> > I feel like I mist be dreaming, but this patch, which was inlcuded
> > in Linus' tree as 40c07ae8daa659b8feb149c84731629386873c16 calls
> > __you_cannot_kzalloc_that_much(), but that does not seem to exist.
> > 
> > On i386 at least that causes a build failure
> 
> It's a purposeful build time error introduced so that invalid calls
> that specify too large kzalloc() length arguments are caught at build
> time.

Thanks, I knew that I had to be missing the point somewhere.
I'll focus my attention on the caller.

-- 
Horms
