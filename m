Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWETWye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWETWye (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWETWye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:54:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964776AbWETWyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:54:33 -0400
Date: Sat, 20 May 2006 15:54:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mel@csn.ul.ie, davej@codemonkey.org.uk, tony.luck@intel.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and
 free_area_init_nodes
Message-Id: <20060520155401.3048be0d.akpm@osdl.org>
In-Reply-To: <200605210017.59984.ak@suse.de>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<200605202327.19606.ak@suse.de>
	<20060520144043.22f993b1.akpm@osdl.org>
	<200605210017.59984.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  
> > Well, it creates arch-neutral common code, teaches various architectures
> > use it.  It's the sort of thing we do all the time.
> > 
> > These things are opportunities to eliminate crufty arch code which few
> > people understand and replace them with new, clean common code which lots
> > of people understand.  That's not a bad thing to be doing.
> 
> I'm not fundamentally against that, but so far it seems to just generate lots of 
> new bugs?  I'm not sure it's really worth the pain.
> 

It is a bit disproportionate.  But in some ways that's a commentary on the
current code.   All this numa/sparse/flat/discontig/holes-in-zones/
virt-memmap/ stuff is pretty hairy, especially in its initalisation.

I'm willing to go through the pain if it ends up with something cleaner
which more people understand a little bit.
