Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945962AbWBOPIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945962AbWBOPIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945964AbWBOPIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:08:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42693 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1945962AbWBOPIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:08:30 -0500
Date: Wed, 15 Feb 2006 09:08:23 -0600
From: Jack Steiner <steiner@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>, Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] ia64: simplify and fix udelay()
Message-ID: <20060215150823.GA27208@sgi.com>
References: <20060214184017.20492.48141.sendpatchset@tomahawk.engr.sgi.com> <200602150908.k1F98dg02934@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602150908.k1F98dg02934@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:08:41AM -0800, Chen, Kenneth W wrote:
> hawkes@sgi.com wrote on Tuesday, February 14, 2006 10:40 AM
> > a preemption and migration to another CPU during the
> > while-loop
> 
> Off topic from the subject line a bit, but related: how many Altix
> SN2 customers in the field turn on CONFIG_PREEMPT? Redhat EL4 doesn't
> turn on preempt, SuSE SLES9 and SLES10 beta don't turn it on either.
> Is there a real benefit of turning that option on for SN2?

AFAICT, no one at SGI uses or plans to use CONFIG_PREEMPT. Most of
our customers use kernels from one of the distros & none at this point
enables preemption. 

The realtime folks here have experimented with CONFIG_PREEMPT but so
far have not seen any significant benefit.

Regardless, we should fix udelay() to handle unsync'ed ITCs.  It would
be nice to have it working.



-- Jack

