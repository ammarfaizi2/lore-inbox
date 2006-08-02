Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWHBHLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWHBHLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWHBHLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:11:46 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16769 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751302AbWHBHLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:11:45 -0400
Date: Wed, 2 Aug 2006 00:13:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [Xen-devel] Re: [PATCH 12 of 13] Pass the mm struct into the pgd_free code so the mm is available here
Message-ID: <20060802071306.GN2654@sequoia.sous-sol.org>
References: <8235caea9d688b78ce4b.1154462450@ezr> <200608020514.52316.ak@suse.de> <44D04577.9000904@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D04577.9000904@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Andi Kleen wrote:
> >nst char *arch_vma_name(struct vm_area_struct *vma);
> >  
> >> 
> >>+#ifndef pgd_free_mm
> >>+#define pgd_free_mm(mm) pgd_free((mm)->pgd)
> >>+#endif
> >>    
> >
> >Sorry, but these ifdefs are too ugly. I would prefer if you 
> >just updated all architectures, even though it will make the patch
> >somewhat bigger
> >  
> I'm fine with doing that, and yes this is ugly.  Will take awhile though 
> - for efficiency of mercurial patch tools, I deprecated all 
> architectures but i386, x86_64, and um from my local tree.  <Slaps head>.

While you're at it, can you please make sure there's some nice changelog
comments.  The current one only has diffstat.

thanks,
-chris
