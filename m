Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314484AbSDTBCq>; Fri, 19 Apr 2002 21:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSDTBCp>; Fri, 19 Apr 2002 21:02:45 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:22674 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314484AbSDTBCp>;
	Fri, 19 Apr 2002 21:02:45 -0400
Date: Sat, 20 Apr 2002 11:00:26 +1000
From: Anton Blanchard <anton@samba.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache
Message-ID: <20020420010026.GC21850@krispykreme>
In-Reply-To: <20020418081843.GE4209@krispykreme> <4490000.1019176339@w-hlinder.des>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hanna,
 
> Thanks Anton for running this. The data on your website will be very
> useful to me. I fixed one problem and put the patch up on sourceforge.
> undo_locked() called dget() while holding the dcache_lock instead of 
> dget_locked() which is designed to be called with the dcache_lock
> held.
> 
> This patch is against 2.5.8 at:
> http://prdownloads.sf.net/lse/fast_walkA1-2.5.8.patch
> 
> However, I recently found a deadlock that no one else has been able
> to reproduce. Could you try doing a find on /proc and tell me if it
> deadlocks? 

Indeed that does deadlock, I'll give the new patch a go (with Pauls
undo_locked suggestion). I did get a dcache BUG() when I tried an SDET
run (lost the details unfortunately) but I'll try to reproduce it with
this patch.

Anton
