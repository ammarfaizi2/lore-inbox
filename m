Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSHASfa>; Thu, 1 Aug 2002 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHASfa>; Thu, 1 Aug 2002 14:35:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15118 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S316500AbSHASf3>;
	Thu, 1 Aug 2002 14:35:29 -0400
Date: Thu, 1 Aug 2002 20:38:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ragnar Kj?rstad <kernel@ragnark.vestdata.no>
Cc: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org, lftp@uniyar.ac.ru,
       lftp-devel@uniyar.ac.ru, apiszcz@mitre.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: Nasty ext2fs bug!
Message-ID: <20020801183825.GA20265@alpha.home.local>
References: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com> <20020801174856.GA29562@clusterfs.com> <20020801202718.S20768@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801202718.S20768@vestdata.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 08:27:18PM +0200, Ragnar Kj?rstad wrote:
> On Thu, Aug 01, 2002 at 11:48:56AM -0600, Andreas Dilger wrote:
> > I find it hard to believe that this would actually make a huge
> > difference, except in the case where the source is throttling bandwidth
> > on a per-connection basis.  Either your network is saturated by the
> > transfer, or some point in between is saturated.  I could be wrong, of
> > course, and it would be interesting to hear the reasoning behind the
> > speedup.
> If some link is saturated with 1000 connections, you will get 1% of the
> bandwith instead of 0.1% if you use 10 concurrent connections. right?

wrong, you'll get 1% of the connections instead of 0.1%. So you'll be
more responsible for the saturation of some active equipments which
are sensible to connections, but this has nothing to do with the
bandwidth, nor the link.

It may be usefull only if you have a very high latency and a small
TCP window, I think.

Cheers,
Willy

