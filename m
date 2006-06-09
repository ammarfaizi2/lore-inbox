Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWFIRVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWFIRVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWFIRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:21:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37038 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030270AbWFIRVn (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 9 Jun 2006 13:21:43 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: markh@compro.net, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <200606091115.50576.Serge.Noiraud@bull.net>
References: <448876B9.9060906@compro.net>
	 <200606091115.50576.Serge.Noiraud@bull.net>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 13:20:37 -0400
Message-Id: <1149873638.3894.195.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 11:15 +0200, Serge Noiraud wrote:
> In the README, you say :
>         ...
>         The exec must be run as root because of the use of mlockall,
>         sched_setscheduler, and sched_setaffinity calls. Sorry but
>         there has been no attempt to use the Linux CAPABILITIES API
>         so that it could be run as regular user. 
>         ...
> 
> It's false if you use the LSM patch from here :
>         http://sourceforge.net/projects/realtime-lsm/ 

Realtime LSM is deprecated, with a reasonably recent PAM and glibc
(Ubuntu Dapper and FC5 should both be good) it's not necessary.

Just add something like:

*               -    rtprio  99
*               -    nice    -20
*               -    memlock 500000

to /etc/security/limits.conf

Lee

