Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291756AbSBYMak>; Mon, 25 Feb 2002 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291809AbSBYMab>; Mon, 25 Feb 2002 07:30:31 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:48829 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S291756AbSBYMaL>; Mon, 25 Feb 2002 07:30:11 -0500
Date: Mon, 25 Feb 2002 17:58:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>, pj@engr.sgi.com,
        focht@ess.nec.de, rml@tech9.net, linux-kernel@vger.kernel.org,
        mingo@elte.hu, colpatch@us.ibm.com, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Message-ID: <20020225175853.B15397@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <Pine.LNX.4.21.0202202337320.10032-100000@sx6.ess.nec.de> <Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com> <20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp> <20020223134743.19cb675f.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020223134743.19cb675f.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Sat, Feb 23, 2002 at 01:47:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 01:47:43PM +1100, Rusty Russell wrote:
> 	But this particular problem did not hurt me, since I now run a 
> "suicide" thread on the dying CPU, making it safe and trivial to manually
> re-queue processes.  The question of what to do with processes which cannot
> be scheduled on any remaining CPUs is another interesting question.

If these are processes that are bound to the CPU to be shut down,
wouldn't it make sense to fail the CPU shut down operation ? If you
are giving enough control to the user to make CPU affinity decisions,
they better know how to cleanup before shutting down a CPU.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
