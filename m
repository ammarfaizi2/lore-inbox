Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWHQRUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWHQRUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWHQRUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:20:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61326 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030186AbWHQRUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:20:46 -0400
Date: Thu, 17 Aug 2006 10:20:30 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060817102030.f8c41330.pj@sgi.com>
In-Reply-To: <20060816110357.B7305@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060815214718.00814767.akpm@osdl.org>
	<20060816110357.B7305@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hope not.  To me, "computing power" means megaflops/sec, or Dhrystones
> > (don't ask) or whatever.  If that's what "cpu_power" is referring to then
> > the name is hopelessly ambiguous with peak joules/sec and a big renaming is
> > due.
> 
> It refers to group's processing power. Perhaps "horsepower" is better term.

Well ... I don't think "horsepower" is a step in the right direction.

Andrew's point was over the word "power", not "cpu".  The term
"cpu_power" suggested to him we were concerned with the power supply
watts consumed by a group of CPUs.  Indeed, both those concerned with
laptop battery lifetimes, and the air conditioning tonnage needed
for big honkin NUMA iron might have reason to be concerned with the
power consumed by CPUs.

Changing the word "cpu" to "horse", but keeping the word "power",
does nothing to address Andrew's point.  Rather it just adds more
confusion.  We are obviously dealing with CPUs here, not horses.

My understanding is that the "cpu_power" of the cpus in a sched group
is rougly proportional to the BogoMIPS of the CPUs in that group.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
