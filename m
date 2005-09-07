Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVIGGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVIGGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 02:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVIGGt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 02:49:56 -0400
Received: from colin.muc.de ([193.149.48.1]:12043 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751016AbVIGGtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 02:49:55 -0400
Date: 7 Sep 2005 08:49:50 +0200
Date: Wed, 7 Sep 2005 08:49:50 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 09/14] x86_64: Don't call enforce_max_cpus when hotplug is enabled
Message-ID: <20050907064950.GB96684@muc.de>
References: <200509032135.j83LZ5Od020541@shell0.pdx.osdl.net> <20050905044821.GH17516@muc.de> <20050906155617.A19439@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906155617.A19439@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 03:56:17PM -0700, Ashok Raj wrote:
> Hi Andi
> 
> On Mon, Sep 05, 2005 at 06:48:21AM +0200, Andi Kleen wrote:
> > On Sat, Sep 03, 2005 at 02:33:26PM -0700, akpm@osdl.org wrote:
> > > 
> > > From: Ashok Raj <ashok.raj@intel.com>
> > > 
> > > No need to enforce_max_cpus when hotplug code is enabled.  This nukes out
> > > cpu_present_map and cpu_possible_map making it impossible to add new cpus in
> > > the system.
> > 
> > I see the point, but the implementation is wrong. If anything
> > we shouldn't do it neither for the !HOTPLUG_CPU case.Why did 
> > you not do it unconditionally? 
> > 
> > I would prefer to keep the special cases for hotplug to be
> > as narrow as possible.
> 
> Link to earlier discussion below
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112317327529855&w=2
> 
> I had suggested that we remove it completely in our discussion but i didnt
> hear anything from you after that, so i thought that was acceptable.

Just because I don't follow up on everything doesn't necessarily
mean the patch is acceptable.

> 
> You had suggested in that discussion that it would be better to add an 
> option for startup. Iam opposed to adding any option, when we certainly know 

I suggested to auto detect it based on ACPI information. I don't 
think I ever wrote anything about an option.

If that is not possible it's better to always use the sequence mechanism.

> there are no users. Earlier based on your suggestion i added a startup
> option to choose ipi broadcast mode, which you promptly removed when you
> put physflat changes. I think its better to not add any option without
> real need. Do you agree?

Yes. 

> Please reply if you want me to remove the !HOTPLUG case which is my 
> preference as well, and maybe while the memory is fresh, we can stick
> with it this time when we are in the same page :-(

Yes, as I wrote earlier hotplug should be removed.

-Andi

P.S.: Don't bother sending me such "blame game" mails again. I will
just d them next time because they're a waste of time.

