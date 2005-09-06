Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVIFW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVIFW46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVIFW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:56:58 -0400
Received: from fmr21.intel.com ([143.183.121.13]:32690 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751098AbVIFW46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:56:58 -0400
Date: Tue, 6 Sep 2005 15:56:17 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 09/14] x86_64: Don't call enforce_max_cpus when hotplug is enabled
Message-ID: <20050906155617.A19439@unix-os.sc.intel.com>
References: <200509032135.j83LZ5Od020541@shell0.pdx.osdl.net> <20050905044821.GH17516@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905044821.GH17516@muc.de>; from ak@muc.de on Mon, Sep 05, 2005 at 06:48:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

On Mon, Sep 05, 2005 at 06:48:21AM +0200, Andi Kleen wrote:
> On Sat, Sep 03, 2005 at 02:33:26PM -0700, akpm@osdl.org wrote:
> > 
> > From: Ashok Raj <ashok.raj@intel.com>
> > 
> > No need to enforce_max_cpus when hotplug code is enabled.  This nukes out
> > cpu_present_map and cpu_possible_map making it impossible to add new cpus in
> > the system.
> 
> I see the point, but the implementation is wrong. If anything
> we shouldn't do it neither for the !HOTPLUG_CPU case.Why did 
> you not do it unconditionally? 
> 
> I would prefer to keep the special cases for hotplug to be
> as narrow as possible.

Link to earlier discussion below

http://marc.theaimsgroup.com/?l=linux-kernel&m=112317327529855&w=2

I had suggested that we remove it completely in our discussion but i didnt
hear anything from you after that, so i thought that was acceptable.

You had suggested in that discussion that it would be better to add an 
option for startup. Iam opposed to adding any option, when we certainly know 
there are no users. Earlier based on your suggestion i added a startup
option to choose ipi broadcast mode, which you promptly removed when you
put physflat changes. I think its better to not add any option without
real need. Do you agree?

Please reply if you want me to remove the !HOTPLUG case which is my 
preference as well, and maybe while the memory is fresh, we can stick
with it this time when we are in the same page :-(

> 
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
