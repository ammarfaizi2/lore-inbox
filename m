Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVBLGQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVBLGQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 01:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVBLGQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 01:16:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50317 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262398AbVBLGQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 01:16:52 -0500
Date: Fri, 11 Feb 2005 22:16:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: colpatch@us.ibm.com, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20050211221610.46bbbd3d.pj@sgi.com>
In-Reply-To: <20050212013744.GC22159@chandralinux.beaverton.ibm.com>
References: <20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
	<20050208095440.GA3976@in.ibm.com>
	<42090C42.7020700@us.ibm.com>
	<20050208124234.6aed9e28.pj@sgi.com>
	<20050209175928.GA5710@chandralinux.beaverton.ibm.com>
	<20050211024606.GB19997@chandralinux.beaverton.ibm.com>
	<20050211012112.4913a3e2.pj@sgi.com>
	<20050212013744.GC22159@chandralinux.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with 97% of what you write, Chandra.


> one more level of indirection(instead of task->cpuset->cpus_allowed
> it will be task->taskclass->res[CPUSET]->cpus_allowed).

No -- two more levels of indirection (task->cpus_allowed becomes
task->taskclass->res[CPUSET]->cpus_allowed).


> But, for your purposes or our discussions one would need only 3 modules
> of the above (core, rcfs and taskclass). 

Ok.  That was not obvious to me until now.  If there is a section in
your documentation that explains this, and addresses the needs and
motivations of someone trying to reuse portions of CKRM in such a
manner, I missed it.  Whatever ...

In any case, on the issue that matters to me right now, we agree:

> It won't be a happy, productive marriage.

Good.  Thanks.  Good luck to you.

> PS to everyone else: Wow, you have lot of patience :)

For sure.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
