Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVCaVT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVCaVT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCaVT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:19:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16655 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262006AbVCaVTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:19:43 -0500
Date: Thu, 31 Mar 2005 23:19:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <roland@topspin.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       mvw@planets.elm.net
Subject: Re: Stack usage tasks
Message-ID: <20050331211941.GJ3185@stusta.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de> <20050331203010.GF3185@stusta.de> <52ll83mtqd.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52ll83mtqd.fsf@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:43:38PM -0800, Roland Dreier wrote:
>     > The task I'm suggesting was therefore:
>     > - remove the -fno-unit-at-a-time in arch/i386/Makefile in your private
>     >   kernel sources
>     > - use gcc 3.4
>     > - reduce the stack usages in call paths > 3kB
> 
> This is a good idea.  However, I might suggest using gcc 4.0 (you'll
> have to use a snapshot now, but the release should only be a few weeks
> away).  A patch went into gcc 4.0 that makes gcc more intelligent
> about sharing stack for variables that cannot be alive at the same
> time, and therefore it may be more feasible to make unit-at-a-time
> work for the i386 kernels.

That's one option.

Jörn, can you send a list of call paths with a stack usage > 3kB when 
compiling with gcc 3.4 and unit-at-a-time (or tell me how to generate 
these lists)?

If fixing a handful of places was sufficient, it was IMHO worth it for 
enabling unit-at-a-time with gcc 3.4 .

>  - R.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

