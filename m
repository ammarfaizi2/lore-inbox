Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUKSXtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUKSXtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUKSXs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:48:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34273 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261671AbUKSXqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:46:12 -0500
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, hari@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       varap@us.ibm.com
In-Reply-To: <20041119153052.21b387ca.akpm@osdl.org>
References: <419CACE2.7060408@in.ibm.com>
	 <200411200256.36218.amgta@yacht.ocn.ne.jp>
	 <20041119153052.21b387ca.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100906944.4987.203.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Nov 2004 15:29:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I haven't tested it yet on any of my machines (due to the hang). 
I am about to give it a try. But my understanding (please update 
me if I am wrong) is,

1) DISCONTIG_MEM support is not working yet - so i can't use any
of my NUMA boxes.

2) AMD64 is not supported - i can't use my Opteron machine.

3) ppc is not supported - i can't use Power3 and Power4 machines.

So, I can only try it on non-NUMA i386 smp boxes. I have few of
those to try. I will give an update next week on my testing.

Thanks,
Badari


On Fri, 2004-11-19 at 15:30, Andrew Morton wrote:
> Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:
> >
> > On Thursday 18 November 2004 23:08, Hariprasad Nellitheertha wrote:
> > 
> > > There was a buggy (and unnecessary) reserve_bootmem call in the kdump
> > > call which was causing hangs during early on some SMP machines. The
> > > attached patch removes that.
> > 
> > Thanks! I also had the same problem.
> 
> So..  How is the crashdump code working now?  I haven't heard from anyone
> who is using it and I haven't gotten onto testing it myself.
> 
> Do we have any feeling for its success rate on various machines, and on its
> ease of use?
> 
> 

