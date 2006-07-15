Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946042AbWGON60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946042AbWGON60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 09:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946048AbWGON60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 09:58:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:64957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1946042AbWGON6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 09:58:25 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Lee Revell <rlrevell@joe-job.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152919240.6374.38.camel@idefix.homelinux.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 09:58:15 -0400
Message-Id: <1152971896.16617.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 09:20 +1000, Jean-Marc Valin wrote:
> > Can't you just make a prio 1 task which signals a prio 99 once say every 
> > second. If the priority 99 task doesn't get the signal after say 2 
> > seconds, it will look for a rt task running wild. At worst it will have to do
> > an O(n) algorith when things have gone wrong, not when everything is 
> > working.
> 
> Well, that would work in sort of preventing a complete lockup, but the
> watchdog wouldn't even know if the task eating lots of CPU is privileged
> (OK) or unprivileged (not OK). Also, the original RLIMIT_RT_CPU feature
> allowed you to really control how much CPU is available to unprivileged
> users, not just prevent them from getting 100% CPU. 

Non-root RT tasks are not "unprivileged" - they have a level of
privileges between a normal user and root.  Really I think it's OK for
these tasks to consume 100% CPU, as the admin has explicitly allowed it.

The only problem is that Ubuntu shipped with this enabled for everyone.

Lee

