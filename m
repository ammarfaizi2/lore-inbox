Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVEREPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVEREPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVEREPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:15:50 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60123 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262078AbVEREPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:15:31 -0400
Date: Tue, 17 May 2005 21:14:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: ntl@pobox.com, dino@in.ibm.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050517211455.2591908e.pj@sgi.com>
In-Reply-To: <20050514104429.7dc92c85.pj@sgi.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050511134235.5cecf85c.pj@sgi.com>
	<20050511135850.3df60a9f.pj@sgi.com>
	<20050513192331.2244ada9.pj@sgi.com>
	<20050514121434.GK3614@otto>
	<20050514100417.5083262d.pj@sgi.com>
	<20050514104429.7dc92c85.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa, Dinakar and/or Nathan,

If the version of this patch that I posted:

	Sat, 14 May 2005 10:44:29 -0700
	Message-Id: <20050514104429.7dc92c85.pj@sgi.com>

with the comment change, and the code change:

 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
-		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
+		cpus_setall(tsk->cpus_allowed);

is one that any of you have tested, and if you agree with it, then with
an "Acked-by:" reply (to that patch), it should make sense to recommend
it to Andrew for inclusion in his and/or Linus's kernel.

I'm still happy with it.  My understanding is that you all are ok with
it as well, and I just need to push it over the finish line.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
