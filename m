Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTBTMje>; Thu, 20 Feb 2003 07:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBTMiy>; Thu, 20 Feb 2003 07:38:54 -0500
Received: from octopussy.utanet.at ([213.90.36.45]:32236 "EHLO
	octopussy.utanet.at") by vger.kernel.org with ESMTP
	id <S265424AbTBTMib>; Thu, 20 Feb 2003 07:38:31 -0500
Date: Thu, 20 Feb 2003 13:48:33 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030220124833.GB4051@lilith.homenet>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030219171432.A6059@smp.colors.kwc> <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

On Wed, Feb 19, 2003 at 08:08:01PM -0300, Rik van Riel wrote:
> On Wed, 19 Feb 2003, Dejan Muhamedagic wrote:
> 
> > cache.  Is it possible to reduce the amount of memory used
> > for cache?
> 
> Yes, you can reduce the size of the cache above which the
> pageout code will only reclaim cache and not application
> data.  To set the percentage to 10% (from the default 5%):
> 
> echo 1 10 > /proc/sys/vm/pagecache

Will that work with rmap15d?  The code seems to support only min
and borrow parameters.  Correct me if I'm wrong.  This is what it
looks like currently:

# cat /proc/sys/vm/pagecache
1       3       20
# mem | grep Cache
Cached:        4569128 kB
SwapCached:     829668 kB
ActiveCache:    136728 kB

> 
> > Finally, there's a third SAP app server, an RS6000 running
> > AIX with the same amount of memory, which seems to be more
> > stable under various loads.
> 
> In that case you're probably familiar with the cache size
> tuning, since AIX has the exact same tuning knob as rmap ;)

AIX vmtune -P is equivalent to the Linux cache-max, but cache-max
is not implemented.

Cheers!

Dejan
