Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbSJBKv0>; Wed, 2 Oct 2002 06:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbSJBKv0>; Wed, 2 Oct 2002 06:51:26 -0400
Received: from dsl-213-023-038-107.arcor-ip.net ([213.23.38.107]:42658 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263034AbSJBKv0>;
	Wed, 2 Oct 2002 06:51:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Kevin Easton <s3159795@student.anu.edu.au>
Subject: Re: 2.4.19 OOPS in kswapd __remove_from_queues
Date: Wed, 2 Oct 2002 12:16:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <20021002155350.A9160@beernut.flames.org.au>
In-Reply-To: <20021002155350.A9160@beernut.flames.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wgYh-0007Yh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 07:53, Kevin Easton wrote:
> On Tue, Oct 1, 2002 at 17:55:31 +0200, Daniel Phillips wrote:
> > Hi Kevin,
> > 
> > Did you try the patch below?  What happened, if anything?
> 
> [snip kswapd oops & patch]
> 
> Yes.. unfortunately, since I posted the original patch, I've seen multiple 
> oopsen in several different places.  I should probably mention here that I'm
> running the pdc202xx.c driver as a plain IDE controller, with linux software
> RAID-1 and ext3 on that.  The instability seems to trigger after copying
> a large amount of data to the partitions on that RAID array (several hundred
> MB usually).  When I copy data to a drive that's on the other (plain VIA) 
> motherboard IDE controller, it doesn't trigger a crash.

Probably not the VM then.  How about reformatting the raid volume with another
filesystem such as ReiserFS or JFS, with a view to eliminating the possibility
that Ext3/jbd is the cause.

-- 
Daniel
