Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUJBOxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUJBOxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUJBOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 10:53:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:57562 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266648AbUJBOxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 10:53:38 -0400
Date: Sat, 2 Oct 2004 20:25:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20041002145521.GA8868@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001230644.39b551af.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 11:06:44PM -0700, Paul Jackson wrote:
> Cpuset Requirements
> ===================
> 
> The three primary requirements that the SGI support engineers
> on our biggest configurations keep telling me are most important
> are:
>   1) isolation,
>   2) isolation, and
>   3) isolation.  
> A big HPC job running on a dedicated set of CPUs and Memory Nodes
> should not lose any CPU cycles or Memory pages to outsiders.
> 
....

> 
> A job running in a cpuset should be able to use various configuration,
> resource management (CKRM for example), cpu and memory (numa) affinity
> tools, performance analysis and thread management facilities within a
> set, including pthreads and MPI, independently from what is happening
> on the rest of the system.
> 
> One should be able to run a stock 3rd party app (Oracle is
> the canonical example) on a system side-by-side with a special
> customer app, each in their own set, neither interfering with
> the other, and the Oracle folks happy that their app is running
> in a supported environment.

One of the things we are working on is to provide exactly something
like this. Not just that, within the isolated partitions, we want
to be able to provide completely different environment. For example,
we need to be able to run or more realtime processes of an application
in one partition while the other partition runs the database portion
of the application. For this to succeed, they need to be completely
isolated.

It would be nice if someone explains a potential CKRM implementation for 
this kind of complete isolation.

Thanks
Dipankar
