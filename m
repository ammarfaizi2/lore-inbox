Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUJCDrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUJCDrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 23:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUJCDrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 23:47:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3460 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267705AbUJCDrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 23:47:04 -0400
Date: Sat, 2 Oct 2004 20:44:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: pwil3058@bigpond.net.au, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041002204441.75b49595.pj@sgi.com>
In-Reply-To: <415F3D4C.6060907@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<415F3D4C.6060907@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus writes:
> 
> That's one of the sticking points.
> That would require that TASKCLASSES and cpumemsets must go along the 
> same hierarchy. With CPUmemsets being the top part of the hierarchy.
> In other words the task classes can not span different cpusets.

Can task classes span an entire cpuset subtree?  I can well imagine that
an entire subtree of the cpuset tree should be managed by the same CKRM
policies and shares.

In particular, if we emulate the setaffinity/mbind/mempolicy calls by
forking a child cpuset to represent the new restrictions on the task
affected by those calls, then we'd for sure want to leave that task in
the same CKRM policy realm as it was before.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
