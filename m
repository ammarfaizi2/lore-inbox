Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWGEUZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWGEUZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWGEUZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:25:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9648 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964989AbWGEUZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:25:37 -0400
Message-ID: <44AC2039.8060806@sgi.com>
Date: Wed, 05 Jul 2006 13:25:29 -0700
From: Chris Sturtivant <csturtiv@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: hadi@cyberus.ca, pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	 <44A020CD.30903@watson.ibm.com>	 <20060626111249.7aece36e.akpm@osdl.org> <44A026ED.8080903@sgi.com>	 <20060626113959.839d72bc.akpm@osdl.org> <44A2F50D.8030306@engr.sgi.com>	 <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com>	 <20060629014050.d3bf0be4.pj@sgi.com>	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	 <20060629094408.360ac157.pj@sgi.com>	 <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>	 <44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org>	 <44A5DBE7.2020704@watson.ibm.com> <44A5EDE6.3010605@watson.ibm.com>	 <20060630205148.4f66b125.akpm@osdl.org> <44A9881F.7030103@watson.ibm.com>	 <44A9BC4D.7030803@watson.ibm.com> <20060703180151.56f61b31.akpm@osdl.org>	 <1152018353.5214.14.camel@jzny2> <44AA86BF.3090600@watson.ibm.com>	 <44AA9951.1060804@watson.ibm.com> <1152041070.5276.29.camel! @jzny2> <44ABC81F.6060405@watson.ibm.com>
In-Reply-To: <44ABC81F.6060405@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> So here's the sequence of pids being used/hashed etc. Please let
> me know if my assumptions are correct ?
>
> 1. Same listener thread opens 2 sockets
>
> On sockfd1, does a bind() using
> 	sockaddr_nl.nl_pid = my_pid1
> On sockfd2, does a bind() using
> 	sockaddr_nl.nl_pid = my_pid2
>
> (one of my_pid1's could by its process pid but doesn't have to be)
>   

For CSA, we are proposing to use a single (multi-threaded) demon that 
combines both the userland components for job and CSA that used to be in 
the kernel.  In this case, the pid will be the same for two connections 
along with the cpu range.  Does what your saying here mean that we 
should choose distinct values for my_pid1 and my_pid2 to avoid the two 
sockets looking the same?  I'm not too familiar with netlink, yet.

Best regards,


--Chris

-- 
-----------------------------------------------------------------
Chris Sturtivant, PhD,
Linux System Software,
SGI
(650) 933-1703
-----------------------------------------------------------------

