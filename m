Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFFCIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFFCIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 22:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUFFCIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 22:08:14 -0400
Received: from ozlabs.org ([203.10.76.45]:48547 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262768AbUFFCIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 22:08:09 -0400
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
	implementation
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040604181233.GF21007@holomorphy.com>
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
Content-Type: text/plain
Message-Id: <1086487651.11454.19.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 12:07:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 04:12, William Lee Irwin III wrote:
> /* William Lee Irwin III:
> >> I'm thoroughly disgusted.
> 
> On Fri, Jun 04, 2004 at 10:47:56AM -0700, Paul Jackson wrote:
> > Yup ... LOL.  One sick piece of code.

We've been here before.  I argued the userspace interface was broken to
require this looping, Linus said it was fine, Ingo said "userspace will
assume < 1024 cpus" and if we get more than that we'll need a new
interface, and that's what glibc does today with its cpu_set_t.

Shades of select-style pain, but it's not likely to change in the near
future.

Note also that saying "Schedule me on CPU 1 and 999" 'succeeds' at the
moment.

Yes, NR_CPUS needs to get to userspace somehow sanely if we want to fix
this in general.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

