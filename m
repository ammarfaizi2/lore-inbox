Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUJHKQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUJHKQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269717AbUJHKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:16:25 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:5015 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268496AbUJHKQX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:16:23 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: lse-tech@lists.sourceforge.net, colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Date: Fri, 8 Oct 2004 12:14:20 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, simon.derr@bull.net,
       frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis>
In-Reply-To: <1097110266.4907.187.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410081214.20907.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thursday 07 October 2004 02:51, Matthew Dobson wrote:
> 1) Rip out sched_groups and move them into the sched_domains.
> 2) Add some reference counting, and eventually locking, to
> sched_domains.
> 3) Rewrite & simplify the way sched_domains are built and linked into a
> cohesive tree.
> 
> This should allow us to support hotplug more easily, simply removing the
> domain belonging to the going-away CPU, rather than throwing away the
> whole domain tree and rebuilding from scratch.  This should also allow
> us to support multiple, independent (ie: no shared root) domain trees
> which will facilitate isolated CPU groups and exclusive domains.  I also
> hope this will allow us to leverage the existing topology infrastructure
> to build domains that closely resemble the physical structure of the
> machine automagically, thus making supporting interesting NUMA machines
> and SMT machines easier.

more flexibility in building the sched_domains is badly needed, so
your effort towards providing this is the right step. I'm not sure
yet whether your big change is really (and already) a simplification,
but what you described sounded for me like getting the chance to
configure the sched_domains at runtime, dynamically, from user
space. I didn't notice any user interface in your patch, or overlooked
it. Could you please describe the API you had in mind for that?

Regards,
Erich

