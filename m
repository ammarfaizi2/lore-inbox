Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUJCDBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUJCDBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJCDBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:01:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:18412 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267454AbUJCDBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:01:41 -0400
Date: Sat, 2 Oct 2004 19:59:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002195905.484d5b97.pj@sgi.com>
In-Reply-To: <415F37F9.6060002@bigpond.net.au>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter writes:
>
> I say this because, 
> strictly speaking and as you imply, the current affinity mechanism is 
> sufficient to provide that isolation BUT it would be a huge pain to 
> implement.

The affects on any given task - where it gets scheduled and where it
allocates memory - can be duplicated using the current affinity
mechanisms (setaffinity/mbind/mempolicy).

However the system wide naming of cpusets, the control of their access,
use and modification, the exclusive rights to a CPU or Memory and the
robust linkage of tasks to these named cpusets are, in my view, just the
sort of system wide resource synchronization that kernels are born to
do, and these capabilities are not provided by the per-task existing
affinity mechanisms.

However, my point doesn't matter much.  Whether its a huge pain, or an
infinite pain, so long as we agree it's more painful than we can
tolerate, that's enough agreement to continue this discussion along
other more fruitful lines.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
