Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbTFRWOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbTFRWOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:14:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:62145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265567AbTFRWOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:14:30 -0400
Message-Id: <5.2.0.9.2.20030618234400.0277b448@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 00:32:48 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler starvation
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1055971842.585.2.camel@teapot.felipe-alfaro.com>
References: <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
 <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
 <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
 <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:30 PM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
>On Wed, 2003-06-18 at 17:54, Mike Galbraith wrote:
> > >To make XMMS skip, just force the X server to do a lot of repainting,
> > >for example, by dragging a big window slowly enough over another one
> > >which requires a lot of painting (Evolution, for example, is a good
> > >candidate as it requires a lot of CPU to repaint uncovered areas). It's
> > >easy to reproduce just after launching XMMS. However, after a while, it
> > >gets difficult to make XMMS to skip sound (it seems the scheduler
> > >adjusts priorities well enough). This is on a PIII 700Mhz laptop with no
> > >niced processes at all.
> >
> > Thanks.  I don't have evolution on my linux box (pine/vi/procmail
> > rules).  ImageMagic ought to give X more than enough spurts of frenetic
> > activity though.  Do you have that, and does image manipulation make xmms
> > stutter as well?  Just moving windows around and changing backgrounds
> > doesn't do anything here.  (500mhz piii/128mb ram btw)
>
>In fact, I can only make XMMS skip sound for a very brief period, just
>after starting it up. After a few seconds, it seems the dynamic
>priorities are adjusted and I can't make XMMS skip sound anymore. To
>reproduce it, open up a big window, then launch XMMS and make it play
>some MP3 file. Then, start moving the big window around. For me, this
>causes XMMS to skip sound for a brief period of time (~5 seconds,
>approx).

If you bump CHILD_PENALTY up (to say 75) you should see a marked improvement.

         -Mike 

