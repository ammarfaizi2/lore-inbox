Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSL2Vu1>; Sun, 29 Dec 2002 16:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSL2Vu1>; Sun, 29 Dec 2002 16:50:27 -0500
Received: from verein.lst.de ([212.34.181.86]:37131 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261855AbSL2Vu0>;
	Sun, 29 Dec 2002 16:50:26 -0500
Date: Sun, 29 Dec 2002 22:58:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more deprectation bits
Message-ID: <20021229225843.A12122@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021229215554.A11360@lst.de> <3E0F6B6B.2FCEC917@digeo.com> <20021229224713.A12011@lst.de> <3E0F6F64.DDE742A3@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E0F6F64.DDE742A3@digeo.com>; from akpm@digeo.com on Sun, Dec 29, 2002 at 01:55:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 01:55:48PM -0800, Andrew Morton wrote:
> > Even if it's safe in that particular case, most code in the kernel runs
> > without BKL.  This patch just makes the deprication of sleep_on
> > explicit.
> 
> This would be more appropriate:

I don't think so.  As you said before sleep_on is perfectly fine for
the small part of code still covered by BKL, so we should not impose
any runtime overhead (i.e. warnings) but rather remind at compile time.

That's what's so nice with the gcc extension (and you won't see it
anyway as long as you stay at egcs 1.1 :))

