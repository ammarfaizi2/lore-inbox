Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUEEVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUEEVvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbUEEVvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 17:51:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:59579 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264811AbUEEVvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 17:51:45 -0400
Date: Wed, 5 May 2004 23:51:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valdis.Kletnieks@vt.edu
Cc: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040505215136.GA8070@wohnheim.fh-wedel.de>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004 14:22:02 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 05 May 2004 13:12:30 +0200, Dominik Karall <dominik.karall@gmx.net>  said:
> 
> > Is there any reason why this patch was applied? Because NVidia users can't 
> > work with the original drivers now without removing this patch every time.
> 
> The NVidia users will also have to back out the regparm patch, or insert
> 'asmlinkage' on all the appropriate definitions in the glue code.  Note that
> the patches on www.minion.de already fix this for the 5341 drivers as of
> 03/24/2004.
> 
> In any case, even though I'm one of those NVidia users, I'm OK with the
> patch being in there - anybody who's clued enough to build and run a -mm
> kernel shouldn't have much trouble figuring out how to build it with 2 patches
> reverted.

I disagree.  -mm is the testing ground for -linus.  If this patch
would only break the nvidia module, I couldn't care less.  But
breaking it in such a way that random kernel memory gets corrupted,
which can soon backfire to the filesystem as well?  That's not what
most people understand when calling something "stable".

If this goes in, we should at least detect the nvidia module and
refuse to load it.  Maybe do the same for other modules as well or
refuse to load any module that doesn't somehow state to be ok with 4k
stacks.  Details don't matter, as long as the filesystems survive.

Jörn

-- 
Das Aufregende am Schreiben ist es, eine Ordnung zu schaffen, wo
vorher keine existiert hat.
-- Doris Lessing
