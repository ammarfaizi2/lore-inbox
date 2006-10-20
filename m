Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946447AbWJTUB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946447AbWJTUB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWJTUB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:01:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37294 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422820AbWJTUB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:01:58 -0400
Date: Fri, 20 Oct 2006 13:01:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061020130141.b5e986dd.pj@sgi.com>
In-Reply-To: <453882AC.3070500@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
	<20061019203744.09b8c800.pj@sgi.com>
	<453882AC.3070500@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Or, another question, how does my patch hijack cpus_allowed? In
> what way does it change the semantics of cpus_allowed?

It limits load balancing for tasks in cpusets containing
a superset of that cpusets cpus.

There are always such cpusets - the top cpuset if no other.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
