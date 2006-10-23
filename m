Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWJWFzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWJWFzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWJWFzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:55:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4797 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751537AbWJWFzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:55:12 -0400
Date: Sun, 22 Oct 2006 22:54:56 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mbligh@google.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061022225456.6adfd0be.pj@sgi.com>
In-Reply-To: <20061022222652.B2526@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<20061022035135.2c450147.pj@sgi.com>
	<20061022222652.B2526@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> group of pinned tasks can completely skew the system load balancing..

Ah - yes.  That was a problem.  If the load balancer couldn't offload
tasks from one or two of the most loaded CPUs (perhaps because they
were pinned.) it tended to give up.

I believe that Christoph is actively working that problem.  Adding him
to the cc list, so he can explain the state of this work more
accurately.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
