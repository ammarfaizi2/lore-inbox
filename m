Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314294AbSDRKrp>; Thu, 18 Apr 2002 06:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSDRKro>; Thu, 18 Apr 2002 06:47:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314294AbSDRKro>;
	Thu, 18 Apr 2002 06:47:44 -0400
Message-ID: <3CBEA42B.5707A305@zip.com.au>
Date: Thu, 18 Apr 2002 03:47:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
CC: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch
In-Reply-To: <Pine.LNX.4.44.0204180306050.4760-100000@skynet> <20020418103219.3ADBAEC@shrek.lisa.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen wrote:
> 
> On Thursday, 18. April 2002 04:26, Mel wrote:
> > This patch is a first cut effort at commenting how the buddy algorithm
> > works for allocating and freeing blocks of pages. No code is changed so
> > the impact is minimal to put it mildly
> 
> Sure?
> 
> > -     index = page_idx >> (1 + order);

It's OK:

-       index = page_idx >> (1 + order);

+       /* index is the number bit inside the free_area_t bitmap stored in
+        * area->map
+        */
+       index = page_idx >> (1 + order);

> Nevertheless, great attempt, Mel.

yes, it is.

-
