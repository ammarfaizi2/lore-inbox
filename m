Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753816AbWKMCcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbWKMCcT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 21:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbWKMCcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 21:32:19 -0500
Received: from mx1.suse.de ([195.135.220.2]:17602 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753816AbWKMCcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 21:32:19 -0500
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Date: Mon, 13 Nov 2006 03:32:07 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de> <20061112175050.A17720@unix-os.sc.intel.com>
In-Reply-To: <20061112175050.A17720@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611130332.07569.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 02:50, Siddha, Suresh B wrote:
> On Sat, Nov 11, 2006 at 04:20:24PM +0100, Andi Kleen wrote:
> > On Saturday 11 November 2006 16:14, Ingo Molnar wrote:
> > > 
> > >  - removed the CPU hotplug hacks, switching the default for small
> > >    systems back from phys-flat to logical-flat. The switching to logical 
> > >    flat mode on small systems fixed sporadic ethernet driver timeouts i 
> > >    was getting on a dual-core Athlon64 system:
> > 
> > That will break CPU hotplug on some Intel systems (Ashok can give details) 
> 
> There is an issue of using clustered mode along with cpu hotplug. More details
> are at the below link.

Thanks Suresh.

> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2

I should add i have no definite proof this is an issue on AMD systems
too, but I changed it there too anyways to better be safe than sorry
(and there is not very much performance difference anyways)

Now if it causes device driver issues that's different of course. I wasn't
aware of this before.

-Andi

