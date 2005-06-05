Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFEQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFEQaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVFEQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 12:30:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16626 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261593AbVFEQaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 12:30:14 -0400
Date: Sun, 5 Jun 2005 09:29:58 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605082616.GA26824@elte.hu>
Message-ID: <Pine.LNX.4.44.0506050830050.23583-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Ingo Molnar wrote:
> 
> but i think the fundamental question remains even on Sunday mornings -
> is the plist overhead worth it? Compared to the simple sorted list we 
> exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
> the 1-100 range], is that a significant practical improvement? By 
> overhead i dont just mean cycle cost, but also architectural flexibility 
> and maintainability.


	You'll have to explain the "architectural flexibility and 
maintainability" costs . Questioning if plist works correctly isn't 
a long term maintainability problem, in my mind. I don't see any 
architectural costs considering the plist API, which is why I saw a clear 
path to integrate plist in the first place. 

	For me it's strictly a speed question. I was reviewing V0.7.40-04 
and it looks like apples and oranges to me. It's more a question of where 
do you perfer the latency , in up() or in down() .. plist is slower for 
non-RT tasks, but non-RT tasks also get the benefit of priority ordering.

Daniel

