Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945902AbWGNXUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945902AbWGNXUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945903AbWGNXUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:20:44 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:4755 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1945902AbWGNXUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:20:44 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sat, 15 Jul 2006 09:20:40 +1000
Message-Id: <1152919240.6374.38.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can't you just make a prio 1 task which signals a prio 99 once say every 
> second. If the priority 99 task doesn't get the signal after say 2 
> seconds, it will look for a rt task running wild. At worst it will have to do
> an O(n) algorith when things have gone wrong, not when everything is 
> working.

Well, that would work in sort of preventing a complete lockup, but the
watchdog wouldn't even know if the task eating lots of CPU is privileged
(OK) or unprivileged (not OK). Also, the original RLIMIT_RT_CPU feature
allowed you to really control how much CPU is available to unprivileged
users, not just prevent them from getting 100% CPU. 

	Jean-Marc
