Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVCXQpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVCXQpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVCXQpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:45:24 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:4464 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262633AbVCXQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:45:14 -0500
Message-ID: <4242EEC3.2000605@netcabo.pt>
Date: Thu, 24 Mar 2005 16:45:55 +0000
From: redoubtable <redoubtable@netcabo.pt>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: undisclosed-recipients:;
Subject: fork() 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2005 16:45:13.0139 (UTC) FILETIME=[D970A830:01C53090]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I read a document on securityfocus about fork bombinb a linux system. 
Although they didn't speak about the effectiveness of resource limits I 
guess that should be discussed because it's possible to make a linux 
machine extremely slow (compared to FreeBSD for instance) even with well 
configured resource limits.
I revised kernel/fork.c and I found a way to prevent this problem by 
removing all associated processes with the parent, but that's far from 
portable and should not be used for the sake of compatibilities. I guess 
the function fork() should be revised.
And what about creating a 'maxprocs' sysctl var (even if left high) when 
the resource limits problem is fixed? It would help security when it is 
needed and wouldn't bother other applications. RLIMITs on login are not 
trustworthy. It should exist a global limit in case someone could spawn 
a shell without limits through some flawed application.

Thanks, and please advise.

