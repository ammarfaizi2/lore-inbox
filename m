Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUJCCvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUJCCvl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 22:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUJCCvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 22:51:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6868 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267685AbUJCCvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 22:51:38 -0400
Date: Sat, 2 Oct 2004 19:49:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: akpm@osdl.org, mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041002194926.06bd0332.pj@sgi.com>
In-Reply-To: <415F34FF.8040806@watson.ibm.com>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	<415ED4A4.1090001@watson.ibm.com>
	<20041002134059.65b45e29.akpm@osdl.org>
	<415F34FF.8040806@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus wrote:
>
> CKRM could do so. We already provide the name space and the class 
> hierarchy.

Just because two things have name spaces and hierarchies, doesn't
make them interchangeable.  Name spaces and hierarchies are just
implementation mechanisms - many interesting, entirely unrelated,
solutions make use of them.

What are the objects named, and what is the relation underlying
the hierarchy?  These must match up.

The objects named in cpusets are subsets of a systems CPUs and Memory
Nodes. The relation underlying the hierarchy is the subset relation on
these sets: if one cpuset node is a descendent of another, then its
CPUs and Memory Nodes are a subset of the others.

What is the corresponding statement for CKRM?

For CKRM to subsume cpusets, there must be an injective map from the
above cpuset objects to CKRM objects, that preserves this subset
relation on cpusets.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
