Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUFEGzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUFEGzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 02:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUFEGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 02:55:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:35864 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264522AbUFEGza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 02:55:30 -0400
Date: Sat, 5 Jun 2004 00:01:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net,
       wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040605000107.60c40ec5.pj@sgi.com>
In-Reply-To: <20040604024153.2b820545.akpm@osdl.org>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604024153.2b820545.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> In that case the cpumask code should provide some API function which
> converts a cpumask_t into (and from?) some canonical and documented form. 
> Then you copy what it gave you to userspace.

Exactly.  I said something similar in my earlier reply.
But not the same.  Andrew nailed it.

And the bitmap code should provide that conversion code,
since cpumask is just (soon, I hope ;) a thin layer on
bitmap.

And there might be bitop or byteorder arch specific code
beneath that.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
