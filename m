Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTEFJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTEFJXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:23:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6303 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262488AbTEFJXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:23:24 -0400
Date: Tue, 6 May 2003 15:08:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030506093856.GA9875@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030506050744.GA29352@in.ibm.com> <20030506082949.F2A3217DE0@ozlabs.au.ibm.com> <20030506093411.GB29352@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506093411.GB29352@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 03:04:11PM +0530, Ravikiran G Thirumalai wrote:
> > Doesn't break with sparce CPU #s, but yes, it is inefficient.
> > 
> 
> If you don't reduce NR_CPUS with CONFIG_NR_CPUS, you waste space (32 bit folks
> won't like it) and if you say change CONFIG_NR_CPUS to 2, 
> and we have cpuid 4 on a 2 way you break right?  If we have to address these
> issues at all, why can't we use the simpler kmalloc_percpu patch
> which  I posted in the morning and avoid so much complexity and arch
> dependency?  

We can have something like that for !CONFIG_NUMA and a NUMA-aware
allocator with additional dereferencing cost for CONFIG_NUMA.
Hopefully gains from numa-awareness will more than offset
dereferencing costs.

Thanks
Dipankar
