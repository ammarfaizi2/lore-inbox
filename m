Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWCVTdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWCVTdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCVTdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:33:19 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42627 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932417AbWCVTdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:33:18 -0500
Date: Wed, 22 Mar 2006 11:33:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Message-ID: <20060322193335.GD15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063752.889921000@sorel.sous-sol.org> <200603221524.17388.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221524.17388.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wednesday 22 March 2006 07:30, Chris Wright wrote:
> 
> > +#define get_kernel_cs() \
> > +	(__KERNEL_CS + (xen_feature(XENFEAT_supervisor_mode_kernel) ? 0 : 1))
> 
> Under what circumstances is that feature set?

When building hypervisor with that support.  It then builds a different
hypercall_page for the guest to use, and both co-exist in ring0.  It's
for running directly on native.

thanks,
-chris
