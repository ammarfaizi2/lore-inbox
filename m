Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUFGGgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUFGGgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 02:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUFGGgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 02:36:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10632 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264298AbUFGGgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 02:36:41 -0400
Date: Sun, 6 Jun 2004 23:44:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: wli@holomorphy.com, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606234416.76e57cb5.pj@sgi.com>
In-Reply-To: <1086564057.18634.29.camel@bach>
References: <16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
	<1086487651.11454.19.camel@bach>
	<20040606051657.3c9b44d3.pj@sgi.com>
	<1086564057.18634.29.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Three things are required.

Thank-you, Rusty.  That makes more sense.  The first step in designing
good API's is to be clear what information it is essential to pass.


> In this case, though, the early example programs for setaffinity all
> used "unsigned long mask; sys_sched_setaffinity(...&mask,
> sizeof(mask))", which was both simple and wrong. 

Yeah ... several layers of suckage are in the kernel bitmap layout,
kernel/user API for passing bitmaps, and low level glibc sched set and
get affinity API.  You identify another one.  Not felony (major)
suckage, just petty (minor).  Annoying none the less.  And the source of
quite a few hours of "software maintenance" work.  This margin is too
small to contain the details ;).

Oh well ... I've done my stint for now (hopeful past tense, again)
trying to leave things a little neater than when I arrived.

I hope to turn now back to the cpuset work that I've been assisting
Simon Derr (Bull) on.

Thanks, Rusty, William, Matthew, Nick and others.  

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
