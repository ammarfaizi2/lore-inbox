Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCSB7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUCSB7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:59:40 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:58893 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261943AbUCSB7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:59:38 -0500
Date: Thu, 18 Mar 2004 17:56:54 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040318175654.435b1639.pj@sgi.com>
In-Reply-To: <1079659184.8149.355.camel@arrakis>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These (cpumask_t/nodemask_t) are nice because they are
> optimized for edge cases (UP for cpumask_t and Non-NUMA for nodemask_t)
> as well as for long mask cases (passing by structs reference). 

When I looked at the assembly code generated on my one lung i386 box for
native gcc 3.3.2, it looked pretty good (to my untrained eye) using a
struct of an array of unsigned longs, both for the single unsigned long
(<= 32 bits) and multiple unsigned long cases.

Except for the sparc64 guys and their friends who disparage passing
structs on the stack, I conjecture that the single implementation of a
struct of an array of unsigned longs is nearly ideal for all
architectures.

... go ahead ... prove me wrong.  It probably won't be hard ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
