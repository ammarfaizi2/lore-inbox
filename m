Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSL2Vi6>; Sun, 29 Dec 2002 16:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSL2Vi6>; Sun, 29 Dec 2002 16:38:58 -0500
Received: from verein.lst.de ([212.34.181.86]:32779 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261733AbSL2Vi5>;
	Sun, 29 Dec 2002 16:38:57 -0500
Date: Sun, 29 Dec 2002 22:47:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more deprectation bits
Message-ID: <20021229224713.A12011@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021229215554.A11360@lst.de> <3E0F6B6B.2FCEC917@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E0F6B6B.2FCEC917@digeo.com>; from akpm@digeo.com on Sun, Dec 29, 2002 at 01:38:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 01:38:51PM -0800, Andrew Morton wrote:
> Christoph Hellwig wrote:
> > 
> > Rename the deprecated attribute to __deprecated to make it obvious
> > this is something special and to avoid namespace clashes.
> > 
> > Mark more functionality deprecated:
> > 
> >  - sleep_on & friends
> 
> Please do not make sleep_on() generate a warning.  Unless you intend
> to do the same to lock_kernel().
> 
> ext3 uses sleep_on().  It is perfectly safe.

Even if it's safe in that particular case, most code in the kernel runs
without BKL.  This patch just makes the deprication of sleep_on
explicit.

> Weaning ext3 off lock_kernel()
> is a large, delicate and thus-far undesigned body of work.  I've been
> working on other stuff and it is quite unlikely that ext3 locking will
> be redesigned in the 2.5 timeframe.

Then ext3 has to live with using depricated interfaces during 2.6,
what's the point?

