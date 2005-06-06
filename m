Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVFFO4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVFFO4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFO4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:56:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43511 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261485AbVFFO4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:56:31 -0400
Date: Mon, 6 Jun 2005 07:56:12 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050606075728.GA13088@elte.hu>
Message-ID: <Pine.LNX.4.44.0506060751470.27907-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Ingo Molnar wrote:
> But indeed it could improve interactivity (but this has not been proven 
> yet) - and also for testing purposes it would sure be useful, so we 
> should perhaps make ALL_TASKS_PI default-on, as Daniel suggests. If that 
> is done then plists are indeed a superior solution. But if in the end we 
> decide to only include RT tasks in the PI mechanism (which could easily 
> happen) then there seems to be little practical difference between 
> sorted lists and plists.

The biggest reason that I suggest this is because when I wrote the 
abstracted PI I gave the user of the API the choice to do RT tasks only or 
all tasks. In the case of fusyn or futex , they will do all tasks .. Once 
you throw in one structure that does all tasks , they may as well all be 
doing it. Or that's how I feel.

Daniel



