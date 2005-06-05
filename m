Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVFEIm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVFEIm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFEIm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:42:57 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:38101 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261531AbVFEImu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:42:50 -0400
Date: Sun, 5 Jun 2005 10:42:24 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
In-Reply-To: <1117958706.20785.243.camel@tglx.tec.linutronix.de>
Message-Id: <Pine.OSF.4.05.10506051014230.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Thomas Gleixner wrote:

> On Sun, 2005-06-05 at 09:58 +0200, Esben Nielsen wrote:
> > On Sun, 5 Jun 2005, Thomas Gleixner wrote:
> > 
> > > [...] 
> > >   *
> > >   * Based on simple lists (include/linux/list.h).
> > > @@ -17,35 +22,50 @@
> > >   * a priority too (the highest of all the nodes), stored in the head
> > >   * of the list (that is a node itself).
> > >   *
> > > - * Addition is O(1), removal is O(1), change of priority of a node is
> > > - * O(1).
> > > + * Addition is O(N), removal is O(1), change of priority of a node is
> > > + * O(N).
> > >   *
> > > - * Addition and change of priority's order is really O(K), where K is
> > > - * a constant being the maximum number of different priorities you
> > > - * will store in the list. Being a constant, it means it is O(1).
> > > - *
> > 
> > What is N? The number of nodes in the list or the number of different
> > priorities? If it is the number of nodes in total this exercise is
> > worthless: You could just as well have a sorted list.
> > 
> > But I hope and also think that the original explanation was correct.
> 
> Sorry, I meant K the number of different priorities. 
> 
> I just find it completely bogus, that O(K) == O(1) for any K != 1. 
> 
> tglx
> 

When K is a constant or bounded by a constant (140 in this application)
any function which is O(K) is O(1) per definition of O! 

Esben

