Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSE3ME3>; Thu, 30 May 2002 08:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSE3ME3>; Thu, 30 May 2002 08:04:29 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:29715 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316594AbSE3ME1>; Thu, 30 May 2002 08:04:27 -0400
Date: Thu, 30 May 2002 12:05:05 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.19 daemonize calls reparent_init for you
Message-ID: <20020530120505.H681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E17DI7X-00030e-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 03:05:07PM +1000, Rusty Russell wrote:
> daemonize() should call reparent_to_init: a classic mistake (I made it
> recently).
> 
> Future potential cleanups:
> 	daemonize() should take mask of signals to allow
> 	kernel_thread() should take a name to copy into ->comm.

Why no generating kernel threads by basically cloning "init"? 

This is what we do anyway (creating a clone of init with special
properties) but by cloning the current process and adjusting
everything needed later to make it appear of a mixture of init
clone and idle process clone.

Comments?

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
