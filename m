Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264529AbUFEHXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbUFEHXO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUFEHXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:23:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:42104 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264529AbUFEHXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:23:13 -0400
Date: Sat, 5 Jun 2004 00:28:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: wli@holomorphy.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net, miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040605002827.2e539991.pj@sgi.com>
In-Reply-To: <20040604190803.GA6651@krispykreme>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
	<20040604190803.GA6651@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William, Anton:

If William recoded his bitmap_to_u32_array() routine, provided elsewhere
on this thread, to take as the length argument 'nwords', not the number
of source u64 words, but rather the number (possibly an odd number) of
u32 dest words, then could that routine be used to significantly simply
this compat_sched_getaffinity() code?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
