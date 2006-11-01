Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946729AbWKAJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946729AbWKAJec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946731AbWKAJec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:34:32 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:50324 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946729AbWKAJeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:34:31 -0500
Message-ID: <45486925.4000201@openvz.org>
Date: Wed, 01 Nov 2006 12:30:13 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>
In-Reply-To: <20061030103356.GA16833@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Consensus/Debated Points
> ------------------------
> 
> Consensus:
> 
> 	- Provide resource control over a group of tasks 
> 	- Support movement of task from one resource group to another
> 	- Dont support heirarchy for now
> 	- Support limit (soft and/or hard depending on the resource
> 	  type) in controllers. Guarantee feature could be indirectly
> 	  met thr limits.
> 
> Debated:
> 	- syscall vs configfs interface

OK. Let's stop at configfs interface to move...

> 	- Interaction of resource controllers, containers and cpusets
> 		- Should we support, for instance, creation of resource
> 		  groups/containers under a cpuset?
> 	- Should we have different groupings for different resources?

I propose to discuss this question as this is the most important
now from my point of view.

I believe this can be done, but can't imagine how to use this...

> 	- Support movement of all threads of a process from one group
> 	  to another atomically?

I propose such a solution: if a user asks to move /proc/<pid>
then move the whole task with threads.
If user asks to move /proc/<pid>/task/<tid> then move just
a single thread.

What do you think?
