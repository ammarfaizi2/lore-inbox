Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVCXSPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVCXSPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVCXSOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:14:51 -0500
Received: from funkmunch.net ([202.173.190.158]:32426 "EHLO mail.funkmunch.net")
	by vger.kernel.org with ESMTP id S262893AbVCXSOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:14:41 -0500
Message-ID: <42430439.6090102@funkmunch.net>
Date: Fri, 25 Mar 2005 04:17:29 +1000
From: Triffid Hunter <triffid_hunter@funkmunch.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050321)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: redoubtable <redoubtable@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fork()
References: <4242EEC3.2000605@netcabo.pt>
In-Reply-To: <4242EEC3.2000605@netcabo.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can limit the max number of processes by putting the following into /etc/security/limits.conf (on my distro, and quite a number of others according to google too)

*	hard	nproc	<max # processes>

you can also limit quite a number of other things in this file, and other files in that directory.

redoubtable wrote:
> Hey,
> 
> I read a document on securityfocus about fork bombinb a linux system. 
> Although they didn't speak about the effectiveness of resource limits I 
> guess that should be discussed because it's possible to make a linux 
> machine extremely slow (compared to FreeBSD for instance) even with well 
> configured resource limits.
> I revised kernel/fork.c and I found a way to prevent this problem by 
> removing all associated processes with the parent, but that's far from 
> portable and should not be used for the sake of compatibilities. I guess 
> the function fork() should be revised.
> And what about creating a 'maxprocs' sysctl var (even if left high) when 
> the resource limits problem is fixed? It would help security when it is 
> needed and wouldn't bother other applications. RLIMITs on login are not 
> trustworthy. It should exist a global limit in case someone could spawn 
> a shell without limits through some flawed application.
> 
> Thanks, and please advise.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
