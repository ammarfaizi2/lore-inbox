Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbTFRVQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbTFRVQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:16:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:62987 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265541AbTFRVQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:16:51 -0400
Subject: Re: O(1) scheduler starvation
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mike Galbraith <efault@gmx.de>
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
	 <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
	 <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
Content-Type: text/plain
Message-Id: <1055971842.585.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 23:30:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 17:54, Mike Galbraith wrote:
> >To make XMMS skip, just force the X server to do a lot of repainting,
> >for example, by dragging a big window slowly enough over another one
> >which requires a lot of painting (Evolution, for example, is a good
> >candidate as it requires a lot of CPU to repaint uncovered areas). It's
> >easy to reproduce just after launching XMMS. However, after a while, it
> >gets difficult to make XMMS to skip sound (it seems the scheduler
> >adjusts priorities well enough). This is on a PIII 700Mhz laptop with no
> >niced processes at all.
> 
> Thanks.  I don't have evolution on my linux box (pine/vi/procmail 
> rules).  ImageMagic ought to give X more than enough spurts of frenetic 
> activity though.  Do you have that, and does image manipulation make xmms 
> stutter as well?  Just moving windows around and changing backgrounds 
> doesn't do anything here.  (500mhz piii/128mb ram btw)

In fact, I can only make XMMS skip sound for a very brief period, just
after starting it up. After a few seconds, it seems the dynamic
priorities are adjusted and I can't make XMMS skip sound anymore. To
reproduce it, open up a big window, then launch XMMS and make it play
some MP3 file. Then, start moving the big window around. For me, this
causes XMMS to skip sound for a brief period of time (~5 seconds,
approx).

