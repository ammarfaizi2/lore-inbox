Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSJXLs3>; Thu, 24 Oct 2002 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265420AbSJXLs3>; Thu, 24 Oct 2002 07:48:29 -0400
Received: from [198.73.180.252] ([198.73.180.252]:11987 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265422AbSJXLs2>;
	Thu, 24 Oct 2002 07:48:28 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
To: maneesh@in.ibm.com, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Thu, 24 Oct 2002 07:47:39 -0400
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com> <3DB7AC97.D31A3CB2@digeo.com> <20021024171528.D5311@in.ibm.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021024114740.78FD37CD3@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:

> On Thu, Oct 24, 2002 at 08:22:07AM +0000, Andrew Morton wrote:
>> Andrew Morton wrote:
>> > 
>> > Hopefully the rcu fix in -mm4 will cure this.
>> 
>> Oh.  It was in -mm3 too.  But something went wrong with the
>> dcache shrinking there.
> 
> Backing out larger-cpu-masks.patch fixes this in -mm3 so, -mm4 should not
> give this problem. Basically callbacks are not getting processed due to
> incorrect rcu_cpu_mask.

Would this affect UP systems?  Had the dentry leak on a UP box with 512m 
memory.  About 400m ended up in unfreeable dentries...

Ed Tomlinson
