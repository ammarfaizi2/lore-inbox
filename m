Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTEVFfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTEVFfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:35:14 -0400
Received: from pop.gmx.net ([213.165.65.60]:56898 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262493AbTEVFfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:35:13 -0400
Message-Id: <5.2.0.9.2.20030522063421.00cc3e90@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 22 May 2003 07:52:44 +0200
To: Rik van Riel <riel@imladris.surriel.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: davidm@hpl.hp.com, "" <linux-kernel@vger.kernel.org>,
       "" <linux-ia64@linuxia64.org>
In-Reply-To: <Pine.LNX.4.50L.0305212038120.5425-100000@imladris.surriel.
 com>
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:38 PM 5/21/2003 -0400, Rik van Riel wrote:
>On Wed, 21 May 2003, Mike Galbraith wrote:
> > At 11:49 PM 5/20/2003 -0700, David Mosberger wrote:
> > >Recently, I started to look into some odd performance behaviors of the
> > >O(1) scheduler.  I decided to document what I found in a web page
> > >at:
> > >
> > >         http://www.hpl.hp.com/research/linux/kernel/o1.php
> >
> > The page mentions persistent starvation.  My own explorations of this
> > issue indicate that the primary source is always selecting the highest
> > priority queue.
>
>It's deeper than that.  The O(1) scheduler doesn't consider
>actual CPU usage as a factor of CPU priority.

Oh, there's no doubt in my mind that it's _much_ deeper than my little 
surface scratchings ;-)

It does consider cpu usage though.  Your run history is right there in your 
accumulated sleep_avg.  Unfortunately (in some ways, fortunate in others.. 
conflict) that information can be diluted down to nothing instantly by new 
input from one wakeup.

         -Mike 

