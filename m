Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314192AbSDVNxx>; Mon, 22 Apr 2002 09:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314200AbSDVNxw>; Mon, 22 Apr 2002 09:53:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27861 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314192AbSDVNxv>;
	Mon, 22 Apr 2002 09:53:51 -0400
Date: Mon, 22 Apr 2002 19:26:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: bonganilinux@mweb.co.za
Cc: linux@hazard.jcu.cz, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.8 compilation fail...
Message-ID: <20020422192627.B18450@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <E16zbyq-0006y2-00@ubermail.mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 01:34:58PM +0000, bonganilinux@mweb.co.za wrote:
> > You can use the attached (text/plain) patch to fix this.
> > 
> > Thanks
> 
> Why will moving init smp_init help? Because as far as I can see
> setup_per_cpu_areas() is called by  start_kernel. But it
> is only defined for SMP so this should do it:

The idea is not just to move smp_init(), but to move 
#ifdef __GENERIC_PER_CPU portion to outside #else of
#ifndef CONFIG_SMP.

__GENERIC_PER_CPU will not be defined for UP and hence 
setup_per_cpu_areas() wil be an empty function in UP case.
Rusty suggested this and I have been using it.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
