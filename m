Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUJLWqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUJLWqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUJLWqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:46:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10383 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268040AbUJLWqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:46:24 -0400
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
In-Reply-To: <200410101445.58897.efocht@hpce.nec.com>
References: <1097110266.4907.187.camel@arrakis>
	 <200410090051.18693.efocht@hpce.nec.com>
	 <1097283956.6470.152.camel@arrakis>
	 <200410101445.58897.efocht@hpce.nec.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097621107.6239.30.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 12 Oct 2004 15:45:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 05:45, Erich Focht wrote:
> On Saturday 09 October 2004 03:05, Matthew Dobson wrote:
> > I personally like to think of it from the top down.  The internal API I
> > came up with looks like:
> > 
> > create_domain(parent_domain, type);
> > destroy_domain(domain);
> > add_cpu_to_domain(cpu, domain);
> I'd suggest adding:
> reparent_domain(domain, new_parent_domain);
> 
> When I said that the domains tree is standing on its leaves I meant
> that the core components are the CPUs. Or the Nodes, if you already
> have them. Or some supernodes, if you already have them. In a "normal"
> filesystem you have the root directory, create subdirectories and
> create files in them. Here you already have the files but not the
> structure (or the simplest possible structure).
> 
> Anyhow, the 4 command API can well be the guts of the directory
> operations API which I proposed.
> 
> Regards,
> Erich

I like that suggestion.  As Paul has been sucked away to other work,
thus giving me a chance to work on my code.  I will be focusing on
getting the cpusets/CKRM style interface working with my sched_domains
API.  I like the reparent_domain() suggestion, and it makes sense with
the 'mv' command, in regards to the filesystem model that cpusets/CKRM
currently uses.

-Matt

