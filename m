Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTBTN5P>; Thu, 20 Feb 2003 08:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTBTN5P>; Thu, 20 Feb 2003 08:57:15 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:45802 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id <S265568AbTBTN5N>; Thu, 20 Feb 2003 08:57:13 -0500
Date: Thu, 20 Feb 2003 15:05:59 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030220150559.A27331@smp.colors.kwc>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030219171432.A6059@smp.colors.kwc> <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com> <20030220124833.GB4051@lilith.homenet> <Pine.LNX.4.50L.0302201019250.2329-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302201019250.2329-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.23i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 2 10 13 22 27 41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

On Thu, Feb 20, 2003 at 10:21:50AM -0300, Rik van Riel wrote:
> On Thu, 20 Feb 2003, Dejan Muhamedagic wrote:
> 
> > # mem | grep Cache
> > Cached:        4569128 kB
> > SwapCached:     829668 kB
> > ActiveCache:    136728 kB
> 
> The "problem" here is that a lot of the memory in Cached: is
> mapped into process address space, so in effect it is process
> memory.
> 
> This is especially true for executables, libraries and shared
> memory segments, which you REALLY want to have treated as process
> memory and not as cache...
> 
> This makes the Cached statistic a bit confusing for administrators.

Is there a way to split the statistics?  It also sounds confusing :)

> > > In that case you're probably familiar with the cache size
> > > tuning, since AIX has the exact same tuning knob as rmap ;)
> >
> > AIX vmtune -P is equivalent to the Linux cache-max, but cache-max
> > is not implemented.
> 
> Doesn't it also have something like the borrow percentage, above
> which AIX will only reclaim from the cache, unless the repaging
> rate of the cache is higher than that of process memory ?

No, not that I'm aware of.  You can check the man page for vmtune
yourself:

http://publibn.boulder.ibm.com/doc_link/en_US/a_doc_lib/cmds/aixcmds6/vmtune.htm

BTW, there is also quite a bit of interesting documentation about
the AIX VMM.

Cheers!

Dejan
