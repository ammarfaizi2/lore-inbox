Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265476AbSJXM3K>; Thu, 24 Oct 2002 08:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265479AbSJXM3K>; Thu, 24 Oct 2002 08:29:10 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44207 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265476AbSJXM3J>;
	Thu, 24 Oct 2002 08:29:09 -0400
Date: Thu, 24 Oct 2002 18:16:51 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021024181651.E5311@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com> <3DB7AC97.D31A3CB2@digeo.com> <20021024171528.D5311@in.ibm.com> <20021024114740.78FD37CD3@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024114740.78FD37CD3@oscar.casa.dyndns.org>; from tomlins@cam.org on Thu, Oct 24, 2002 at 07:47:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:47:39AM -0400, Ed Tomlinson wrote:
> Maneesh Soni wrote:
> 
> > On Thu, Oct 24, 2002 at 08:22:07AM +0000, Andrew Morton wrote:
> >> Andrew Morton wrote:
> >> > 
> >> > Hopefully the rcu fix in -mm4 will cure this.
> >> 
> >> Oh.  It was in -mm3 too.  But something went wrong with the
> >> dcache shrinking there.
> > 
> > Backing out larger-cpu-masks.patch fixes this in -mm3 so, -mm4 should not
> > give this problem. Basically callbacks are not getting processed due to
> > incorrect rcu_cpu_mask.
> 
> Would this affect UP systems?  Had the dentry leak on a UP box with 512m 
> memory.  About 400m ended up in unfreeable dentries...

Actually problem does not appear for SMP (with default NRCPUS) kernel as it getsproper rcu_cpu_mask and for UP it is not correct.

Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
