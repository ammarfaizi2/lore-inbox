Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWKIK76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWKIK76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 05:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWKIK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 05:59:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10410 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932502AbWKIK75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 05:59:57 -0500
Date: Thu, 9 Nov 2006 02:59:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, suresh.b.siddha@intel.com, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061109025928.cd51f505.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610230901470.27654@schroedinger.engr.sgi.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<20061022035135.2c450147.pj@sgi.com>
	<20061022222652.B2526@unix-os.sc.intel.com>
	<20061022225456.6adfd0be.pj@sgi.com>
	<453C5AF4.8070707@yahoo.com.au>
	<Pine.LNX.4.64.0610230901470.27654@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch is currently residing in your *-mm stack, as:

  cpuset-remove-sched-domain-hooks-from-cpusets.patch

If it's easy for you to keep track of, I'd like to ask that you don't
push this to Linus until Dinakar and I (with the consent of various
mm experts) settle on the replacement mechanism for dealing with
sched domain partitioning (or whatever that turns in to.)

At the rate Dinakar and I are progressing, this likely means that this
"... remove ... hooks ..." patch will be sitting in *-mm through the
2.6.20 work, and go on to Linus for 2.6.21.

There are some folks actually depending on this mechanism, such as
some real time folks using this to inhibit load balancing on their
isolated CPUs.  It would be polite not to yank out one mechanism
before its replacement is available.

If this sounds like a pain, or you'd just rather not baby sit this in
*-mm that long, then I'd have you drop the patch before I had you send
it to Linus without an accompanying replacement.

All else equal, I kind of like leaving this patch in *-mm for now, as
it puts a stake in the ground, indicating that the current connection
between the per-cpuset "cpu_exclusive" flag and sched domain partitions
is sitting on death row.

There seems to be a general concensus that death row is a good place for
that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
