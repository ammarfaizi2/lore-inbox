Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUH1VDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUH1VDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUH1VDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:03:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39574 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266884AbUH1VCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:02:43 -0400
Date: Sat, 28 Aug 2004 22:59:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-ID: <20040828205933.GC8716@suse.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151544.GB12772@fs.tum.de> <098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com> <20040828162633.GG12772@fs.tum.de> <20040828125816.206ef7fa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828125816.206ef7fa.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28 2004, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> >  > Anything you put in BUG_ON() must *NOT* have side effects.
> >  >...
> > 
> >  I'd have said exactly the same some time ago, but I was convinced by 
> >  Arjan that if done correctly, a BUG_ON() with side effects is possible  
> >  with no extra cost even if you want to make BUG configurably do nothing.
> 
> Nevertheless, I think I'd prefer that we not move code which has
> side-effects into BUG_ONs.  For some reason it seems neater that way.
> 
> Plus one would like to be able to do
> 
> 	BUG_ON(strlen(str) > 22);
> 
> and have strlen() not be evaluated if BUG_ON is disabled.
> 
> A minor distinction, but one which it would be nice to preserve.

Precisely, I fully agree (even though BUG_ON() will never be defined
away, if you should not do the check kill it completely).

-- 
Jens Axboe

