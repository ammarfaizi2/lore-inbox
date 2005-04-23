Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVDWX3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVDWX3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVDWX3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:29:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52893 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262174AbVDWX32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:29:28 -0400
Date: Sat, 23 Apr 2005 16:26:40 -0700
From: Paul Jackson <pj@sgi.com>
To: nickpiggin@yahoo.com.au
Cc: dino@in.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050423162640.69ccbabc.pj@sgi.com>
In-Reply-To: <20050419133431.2e389d57.pj@sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
	<20050419001926.605a6b59.pj@sgi.com>
	<1113897440.5074.62.camel@npiggin-nld.site>
	<20050419133431.2e389d57.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago, Nick wrote:
> Well the scheduler simply can't handle it, so it is not so much a
> matter of pushing - you simply can't use partitioned domains and
> meaningfully have a cpuset above them.

And I (pj) replied:
> Translating that into cpuset-speak, I think what you mean is ...

I then went on to ask some questions.  I haven't seen a reply.
I probably wrote too many words, and you had more pressing matters
to deal with.  Which is fine.

Let's make this simpler.

Ignore cpusets -- let's just talk about a tasks cpus_allowed value,
and scheduler domains.  Think of cpusets as just a strange way of
setting a tasks cpus_allowed value.

Question:

    What happens if we have say two isolated scheduler domains
    on a system, covering say two halves of the system, and
    some task has its cpus_allowed set to allow _all_ CPUs?

What kind of pain does that cause?  I'm hoping you will say that
the only pain it causes is that the task will only run on one
half of the system, even if the other half is idle.  And that
so long as I don't mind that, it's no problem to do this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
