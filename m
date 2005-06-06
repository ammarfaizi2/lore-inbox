Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFFPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFFPFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFFPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:05:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36602 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261498AbVFFPFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:05:09 -0400
Date: Mon, 6 Jun 2005 08:04:53 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050606073229.GA9143@elte.hu>
Message-ID: <Pine.LNX.4.44.0506060800300.27907-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Ingo Molnar wrote:
> 
> yes, it's supposed to be used for user-space PI too. What do you mean by 
> 'completely bounded'. Do you consider the current worst-case O(100) 
> property of plists a 'completely bounded' solution?
> 
> i dont think fusyn's should be made available to non-RT tasks. If this 
> restriction is preserved then fusyn's would become O(max_nr_RT_tasks) 
> too.

	I think making fusyn RT tasks only would be asking a lot. Fusyn 
replaces Futex, and they are both used in pthreads. So non-RT tasks 
wouldn't be able to use pthreads in userspace, or a big chunk of pthread 
..

Daniel

