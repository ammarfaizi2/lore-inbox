Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWJWF7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWJWF7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWJWF7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:59:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17085 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751542AbWJWF7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:59:51 -0400
Date: Sun, 22 Oct 2006 22:59:35 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, nickpiggin@yahoo.com.au,
       mbligh@google.com, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061022225935.5baac180.pj@sgi.com>
In-Reply-To: <20061022213052.A2526@unix-os.sc.intel.com>
References: <20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
	<20061020144153.b40b2cc9.pj@sgi.com>
	<20061020223553.GA14357@in.ibm.com>
	<20061020161403.C8481@unix-os.sc.intel.com>
	<20061020223738.2919264e.pj@sgi.com>
	<20061022213052.A2526@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Ok. I went to implementation details(and ended up less straight forward..) but
> my main intention was to say that we need to retain some sort of hierarchical 
> shape too, while creating these domain partitions.

Good points.

Getting cpusets to work in a hierarchical organization managing a large
system is a key goal of mine.

That means shaping the API's so that they fit the structure of various
users, so that the right person or program can make the right decision
at the right time, easily, and have it all work.

Take a look at my "no need to load balance" flag idea, in my post
a few minutes ago responding to Nick.  That feels to me like it
might be an API that fits the users space, understanding and needs
well, while still giving us what we need to be able to reduce the
size of sched domain partitions on huge systems, where possible.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
