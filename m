Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbSI2Nr4>; Sun, 29 Sep 2002 09:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262477AbSI2Nr4>; Sun, 29 Sep 2002 09:47:56 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:18698 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262476AbSI2Nrz>; Sun, 29 Sep 2002 09:47:55 -0400
Date: Sun, 29 Sep 2002 14:53:07 +0100
From: John Levon <levon@movementarian.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@digeo.com>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
Message-ID: <20020929135307.GA80312@compsoc.man.ac.uk>
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com> <200209290915.52661.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209290915.52661.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17veVP-000D9r-00*6gvyIgs4Mog* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 09:15:52AM -0400, Ed Tomlinson wrote:

> How about this (untested) instead.  If we can avoid using cachep->slabs_free its 
> a good thing.  Why use three lists when two can do the job?  I use a loop to clean 
> the partial list since its possible that for some caches we may want to have more
> than one slabp of buffer.

This patch seems to work for me too (though I have tested it only
lightly)

At least it fixes the false kmem_cache_destroy() report vs. 2.5.39

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
