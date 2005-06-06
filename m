Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFFOuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFFOuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:50:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51195 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261482AbVFFOuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:50:18 -0400
Date: Mon, 6 Jun 2005 07:49:59 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050606074458.GA11875@elte.hu>
Message-ID: <Pine.LNX.4.44.0506060747550.27907-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Ingo Molnar wrote:

> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > 	For me it's strictly a speed question. I was reviewing 
> > V0.7.40-04 and it looks like apples and oranges to me. It's more a 
> > question of where do you perfer the latency , in up() or in down() .. 
> > plist is slower for non-RT tasks, but non-RT tasks also get the 
> > benefit of priority ordering.
> 
> what benefit do non-RT tasks get from plists, compared to the ordered 
> list? Non-RT tasks are not PI handled in any way.

The original wait list was partial ordered, wasn't it? RT tasks on the 
front, non-RT at the back. Now the whole list is sorted (including non RT 
tasks) . So non-RT task will get the lock in priority sorted order, as 
opposed to just random. Like you said, there is no PI done.


Daniel

