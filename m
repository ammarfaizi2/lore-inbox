Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVLBXs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVLBXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVLBXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:48:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:35565 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751054AbVLBXs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:48:27 -0500
Date: Sat, 3 Dec 2005 00:48:26 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [discuss] Re: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202234826.GG9766@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain> <20051202114349.GL997@wotan.suse.de> <20051202225156.GC3727@localhost.localdomain> <20051202230206.GF9766@wotan.suse.de> <20051202234330.GA7426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202234330.GA7426@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 03:43:30PM -0800, Ravikiran G Thirumalai wrote:
> On Sat, Dec 03, 2005 at 12:02:06AM +0100, Andi Kleen wrote:
> > On Fri, Dec 02, 2005 at 02:51:56PM -0800, Ravikiran G Thirumalai wrote:
> > > On Fri, Dec 02, 2005 at 12:43:49PM +0100, Andi Kleen wrote:
> > > > And are you sure it will work with k8topology.c. Doesn't look like
> > > > that to me.
> > > 
> > > I don't have a K8 box yet :(, so I cannot confirm either ways.  
> > > But I thought newer opterons need to use  ACPI_NUMA instead...
> > 
> > k8topology still needs to work - e.g. for LinuxBios and users which use
> > acpi=off and as a fallback for broken SRAT tables. You can't break it right now.
> >
> 
> I don't think this breaks K8 per-se, because x86_cpu_to_apicid[] is setup if
> acpi is compiled in and k8topology sets up apicid_to_node[] at
> k8_scan_nodes. That said, I don't know for sure as I don't have a K8 yet. If
> someone can test this patch on a opteron, compiled with
> ACPI_NUMA as well as K8, (but which falls back to K8 at boot), 
> it will be helpful.

I can do that with the next patch.

-Andi
