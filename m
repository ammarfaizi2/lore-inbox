Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVLOTBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVLOTBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVLOTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:01:53 -0500
Received: from serv01.siteground.net ([70.85.91.68]:58330 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750940AbVLOTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:01:52 -0500
Date: Thu, 15 Dec 2005 11:01:42 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] [patch 1/3] x86_64: Node local pda take 2 -- early cpu_to_node
Message-ID: <20051215190142.GB3882@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain> <20051215094437.GY23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215094437.GY23384@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 10:44:37AM +0100, Andi Kleen wrote:
> On Wed, Dec 14, 2005 at 06:33:45PM -0800, Ravikiran G Thirumalai wrote:
> > + * info.
> > + */
> > +void __init init_cpu_to_node(void)
> > +{
> > +	int i;	
> > + 	for (i = 0; i < NR_CPUS; i++)
> > + 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
> > +}
> 
> I would prefer it if you moved that to numa.c and run always 
> (even for the k8topology case). Otherwise k8topology will behave
> differently whether CONFIG_ACPI_NUMA is set or not, and I don't like
> that.

Sure!  I moved it to srat.c based on your suggestion to my earlier post.  
I will move this to numa.c.

Thanks,
Kiran
