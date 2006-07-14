Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWGNJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWGNJjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGNJjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:39:23 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:17863 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1161007AbWGNJjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:39:15 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152809039.8237.48.camel@mindpipe>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Fri, 14 Jul 2006 19:39:11 +1000
Message-Id: <1152869952.6374.8.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was not merged.
> 
> This problem should be addressed by a userspace RT watchdog.  Ubuntu
> should not have shipped their system with unlimited non-root realtime
> enabled and no watchdog.

Does such a daemon currently exist? Even then, is there any way to
police all unprivileged RT apps without introducing an O(N) operation
running continuously at max rt priority? Sort of defeats the purpose of
having an O(1) scheduler, no? I assume the RT check can be some in O(1)
time in the kernel, right?

About Ubuntu, I agree it wasn't a smart thing to do (I'm not an Ubuntu
devel, so I don't know what the reason was), but it would be nice if
this could be fixed without having to entirely remove the unprivileged
real-time feature. In the end, I'm not sure what the best solution is
(just an RT audio developer).

	Jean-Marc
