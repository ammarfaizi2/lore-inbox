Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269422AbUJGAUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269422AbUJGAUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUJGAUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:20:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62402 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269422AbUJGAUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:20:35 -0400
Message-Id: <200410070016.i970GSWx009446@owlet.beaverton.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
cc: colpatch@us.ibm.com, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
In-reply-to: Your message of "Thu, 07 Oct 2004 09:23:05 +1000."
             <41647E59.9080700@bigpond.net.au> 
Date: Wed, 06 Oct 2004 17:16:28 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    It's not so much whether they NEED their own scheduler, etc. as whether 
    it should be possible for them to have their own scheduler, etc.  With a 
    configurable scheduler (such as ZAPHOD) this could just be a matter of 
    having separate configuration variables for each cpuset (e.g. if a 
    cpuset has been created to contain as bunch of servers there's no need 
    to try and provide good interactive response for its tasks (as none of 
    them will be interactive) so the interactive response mechanism can be 
    turned off in that cpuset leading to better server response and throughput).

Providing configurable schedulers is a feature/bug/argument completely
separate from cpusets.  Let's stay focused on that for now.

Two concrete examples for cpusets stick in my mind:

    * the department that has been given 16 cpus of a 128 cpu machine,
      is free to do what they want with them, and doesn't much care
      specifically how they're laid out. Think general timeshare.

    * the department that has been given 16 cpus of a 128 cpu machine
      to run a finely tuned application which expects and needs everybody
      to stay off those cpus. Think compute-intensive.

Correct me if I'm wrong, but CKRM can handle the first, but cannot
currently handle the second.  And the mechanism(s) for creating either
situation are suboptimal at best and non-existent at worst.

Rick
