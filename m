Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSEVDzD>; Tue, 21 May 2002 23:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSEVDzC>; Tue, 21 May 2002 23:55:02 -0400
Received: from dsl-213-023-040-073.arcor-ip.net ([213.23.40.73]:46246 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316844AbSEVDzC>;
	Tue, 21 May 2002 23:55:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] buffermem_pages removal (5/5)
Date: Wed, 22 May 2002 05:53:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020521141015.E15796@infradead.org> <20020521185340.A694@infradead.org> <3CEA9193.10F45174@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ANBv-0001sA-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 May 2002 20:27, Andrew Morton wrote:
> Christoph Hellwig wrote:
> > 
> > Yho sais all blockdev mapping have to stay ZONE_NORMAL?
> 
> Three trillion filesystems for which we don't have a mkfs which
> access bh->b_data all over the place :(

It's time to change all the bh->b_data to bh_data(bh) and b_data
to _b_data /* don't use */

-- 
Daniel
