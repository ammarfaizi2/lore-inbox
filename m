Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWHDFyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWHDFyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWHDFyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:54:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161043AbWHDFyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:54:19 -0400
Date: Thu, 3 Aug 2006 22:53:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-Id: <20060803225357.e9ab5de1.akpm@osdl.org>
In-Reply-To: <1154667875.11382.37.camel@localhost.localdomain>
References: <44D1CC7D.4010600@vmware.com>
	<20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com>
	<20060803200136.GB28537@kroah.com>
	<44D2B678.6060400@xensource.com>
	<20060803211850.3a01d0cc.akpm@osdl.org>
	<1154667875.11382.37.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 15:04:35 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Thu, 2006-08-03 at 21:18 -0700, Andrew Morton wrote:
> > > As far as LKML is concerned, the only interface which matters is the 
> > > Linux -> <something> interface, which is defined within the scope of the 
> > > Linux development process.  That's what paravirt_ops is intended to be.
> > 
> > I must confess that I still don't "get" paravirtops.  AFACIT the VMI
> > proposal, if it works, will make that whole layer simply go away.  Which
> > is attractive.  If it works.
> 
> Everywhere in the kernel where we have multiple implementations we want
> to select at runtime, we use an ops struct.  Why should the choice of
> Xen/VMI/native/other be any different?

VMI is being proposed as an appropriate way to connect Linux to Xen.  If
that is true then no other glue is needed.

The central point here is whether that is right.

> Yes, we could force native and Xen to work via VMI, but the result would
> be less clear, less maintainable, and gratuitously different from
> elsewhere in the kernel.

I suspect others would disagree with that.  We're at the stage of needing
to see code to settle this.

>  And, of course, unlike paravirt_ops where we
> can change and add ops at any time, we can't similarly change the VMI
> interface because it's an ABI (that's the point: the hypervisor can
> provide the implementation).

hm.  Dunno.  ABIs can be uprevved.  Perhaps.
