Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVFEIEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVFEIEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFEIEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:04:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41857
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261517AbVFEIEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:04:32 -0400
Subject: Re: patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <Pine.OSF.4.05.10506050953040.4252-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506050953040.4252-100000@da410.phys.au.dk>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 10:05:06 +0200
Message-Id: <1117958706.20785.243.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 09:58 +0200, Esben Nielsen wrote:
> On Sun, 5 Jun 2005, Thomas Gleixner wrote:
> 
> > [...] 
> >   *
> >   * Based on simple lists (include/linux/list.h).
> > @@ -17,35 +22,50 @@
> >   * a priority too (the highest of all the nodes), stored in the head
> >   * of the list (that is a node itself).
> >   *
> > - * Addition is O(1), removal is O(1), change of priority of a node is
> > - * O(1).
> > + * Addition is O(N), removal is O(1), change of priority of a node is
> > + * O(N).
> >   *
> > - * Addition and change of priority's order is really O(K), where K is
> > - * a constant being the maximum number of different priorities you
> > - * will store in the list. Being a constant, it means it is O(1).
> > - *
> 
> What is N? The number of nodes in the list or the number of different
> priorities? If it is the number of nodes in total this exercise is
> worthless: You could just as well have a sorted list.
> 
> But I hope and also think that the original explanation was correct.

Sorry, I meant K the number of different priorities. 

I just find it completely bogus, that O(K) == O(1) for any K != 1. 

tglx


