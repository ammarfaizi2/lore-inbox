Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWCVUyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWCVUyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWCVUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:54:21 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39808 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932719AbWCVUyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:54:20 -0500
Date: Wed, 22 Mar 2006 12:54:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Message-ID: <20060322205437.GH15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063752.437169000@sorel.sous-sol.org> <200603221445.46490.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221445.46490.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Wednesday 22 March 2006 07:30, Chris Wright wrote:
> > Abstract the code that sets up interrupt and exception gates, and
> > add a separate subarch implementation for Xen.
> 
> AFAIK the only difference is that Xen uses a table of them to pass
> the hypervisor and normal Linux calls the macros directly, right?

Yes.

> I would suggest you just use the table for normal Linux too
> and make the function that processes them natively !CONFIG_XEN
> I guess it will make the code smaller for the normal case and people happy.

Hadn't considered that type of consolidation.  So load_idt() would
generally be one step further from lidt insn on native, which shouldn't
be a problem.  Looks like kexec would need to be taught about building
the table.

thanks,
-chris
