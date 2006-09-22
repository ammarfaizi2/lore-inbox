Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWIVAYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWIVAYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIVAYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:24:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23951 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932130AbWIVAYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:24:45 -0400
Date: Thu, 21 Sep 2006 17:24:27 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: menage@google.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060921172427.25ddb7ea.pj@sgi.com>
In-Reply-To: <1158883601.6536.223.camel@linuxchandra>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	<1158798715.6536.115.camel@linuxchandra>
	<20060920173638.370e774a.pj@sgi.com>
	<6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	<1158803120.6536.139.camel@linuxchandra>
	<6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	<1158869186.6536.205.camel@linuxchandra>
	<6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	<1158875062.6536.210.camel@linuxchandra>
	<6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
	<1158883601.6536.223.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> There are two (competing) memory controllers in the kernel. But, distro
> can turn only one ON. 

Huh - time for me to play the dummy again ...

My (fog shrouded) vision of the future has:
 1) mempolicy - provides fine grained memory placement for task on self
 2) cpuset - provides system wide cpu and memory placement for unrelated tasks
 3) some form of resource groups - measures and limits proportion of various
    resources used, including cpu cycles, memory pages and network bandwidth,
    by collections of tasks.k

Both (2) and (3) need to group tasks in flexible ways distinct from the
existing task groupings supported by the kernel.

I thought that Paul M suggested (2) and (3) use common underlying
grouping or 'bucket' technology - the infrastructure that separates
tasks into buckets and can be used to associate various resource
metrics and limits with each bucket.

I can't quite figure out whether you have in mind above:
 * a conflict between two competing memory controllers for (3),
 * or a conflict between cpusets and one memory controller for (3).

And either way, I don't see what that has to do with the underling
bucket technology - how we group tasks generically.

Guess I am missing something ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
