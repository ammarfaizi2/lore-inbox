Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDDEiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDDEiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 00:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDDEiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 00:38:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12194 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261537AbVDDEiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 00:38:11 -0400
Date: Sun, 3 Apr 2005 21:36:36 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403213636.05cddf52.pj@engr.sgi.com>
In-Reply-To: <4250C19F.9070801@myrealbox.com>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<4250C19F.9070801@myrealbox.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy wrote:
> Not that I really know what I'm talking about here, but this sounds 
> highly parallelizable.

I doubt it.  If we are testing the cost of a migration between CPUs
alpha and beta, and at the same time testing betweeen CPUs gamma and
delta, then often there will be some hardware that is shared by both the
<alpha, beta> path, and the <gamma, delta> path.  This would affect the
test results.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
