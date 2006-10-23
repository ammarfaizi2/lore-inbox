Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWJWGmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWJWGmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWJWGmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:42:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64970 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751613AbWJWGmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:42:15 -0400
Date: Sun, 22 Oct 2006 23:41:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, akpm@osdl.org, mbligh@google.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061022234152.baaf4624.pj@sgi.com>
In-Reply-To: <453C5E77.2050905@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061022225108.21716614.pj@sgi.com>
	<453C5E77.2050905@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> These are both part of the same larger solution, which is to
> partition domains. isolated CPUs are just the case of 1 CPU in
> its own domain (and that's how they are implemented now).

and later, he also wrote:
> I think this is much more of an automatic behind your back thing.

I got confused there.

I agree that if we can do a -good- job of it, then an implicit,
automatic solution is better for the problem of reducing sched domain
partition sizes on large systems than yet another manual knob.

But I thought that it was good idea, with general agreement, to provide
an explicit control of isolated cpus for the real-time folks, even if
under the covers it use sched domain partitions of size 1 to implement
it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
