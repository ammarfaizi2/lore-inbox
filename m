Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUJCFMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUJCFMp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 01:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUJCFMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 01:12:45 -0400
Received: from gizmo06ps.bigpond.com ([144.140.71.41]:12496 "HELO
	gizmo06ps.bigpond.com") by vger.kernel.org with SMTP
	id S264085AbUJCFMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 01:12:43 -0400
Message-ID: <415F8A47.5010305@bigpond.net.au>
Date: Sun, 03 Oct 2004 15:12:39 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <20041002201933.41e4cdc4.pj@sgi.com> <415F77A7.4070207@bigpond.net.au> <20041002214715.6d60813d.pj@sgi.com>
In-Reply-To: <20041002214715.6d60813d.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Peter wrote:
> 
>>Of course, this [kernel compile option] makes gradual movement
>>from one model to the other difficult to say the least.
> 
> 
> To say the least.
> 
> It might be possible to continue to support current affinity calls
> (setaffinity/mbind/mempolicy) even while removing the duplication of
> affinity masks between tasks and cpusets.
> 
> If each call to set a tasks affinity resulted in moving that task into
> its very own cpuset (unless it was already the only user of its cpuset),
> and if the calls to load and store task->{cpus,mems}_allowed in the
> implementation of these affinity sys calls were changed to load and
> store those affinity masks in the tasks cpuset instead.
> 
> I'm just brainstorming here ... this scheme could easily have some
> fatal flaw that I'm missing at the moment.

Provided overlapping sets are allowed it should be feasible.  However, 
I'm not a big fan of overlapping sets as it would make using different 
CPU scheduling configurations in each set more difficult (maybe even 
inadvisable) but that's a different issue.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
