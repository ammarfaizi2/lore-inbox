Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVLPAUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVLPAUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVLPAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:20:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:48273 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751102AbVLPAUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:20:02 -0500
Date: Fri, 16 Dec 2005 01:20:01 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] [patch 1/3] x86_64: Node local pda take 2 -- early cpu_to_node
Message-ID: <20051216002001.GO23384@wotan.suse.de>
References: <20051215023345.GB3787@localhost.localdomain> <20051215094437.GY23384@wotan.suse.de> <20051215190142.GB3882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215190142.GB3882@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 11:01:42AM -0800, Ravikiran G Thirumalai wrote:
> On Thu, Dec 15, 2005 at 10:44:37AM +0100, Andi Kleen wrote:
> > On Wed, Dec 14, 2005 at 06:33:45PM -0800, Ravikiran G Thirumalai wrote:
> > > + * info.
> > > + */
> > > +void __init init_cpu_to_node(void)
> > > +{
> > > +	int i;	
> > > + 	for (i = 0; i < NR_CPUS; i++)
> > > + 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
> > > +}
> > 
> > I would prefer it if you moved that to numa.c and run always 
> > (even for the k8topology case). Otherwise k8topology will behave
> > differently whether CONFIG_ACPI_NUMA is set or not, and I don't like
> > that.
> 
> Sure!  I moved it to srat.c based on your suggestion to my earlier post.  
> I will move this to numa.c.

Sorry for changing my mind on this. I hope you can bear with me.

-Andi
