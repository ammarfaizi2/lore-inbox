Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWHDI3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWHDI3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWHDI3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:29:19 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:55473 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030199AbWHDI3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:29:18 -0400
Subject: Re: A proposal - binary
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
In-Reply-To: <20060804002107.c0f9ba25.akpm@osdl.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>
	 <1154667875.11382.37.camel@localhost.localdomain>
	 <20060803225357.e9ab5de1.akpm@osdl.org>
	 <1154675100.11382.47.camel@localhost.localdomain>
	 <20060804002107.c0f9ba25.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 18:29:14 +1000
Message-Id: <1154680155.11382.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 00:21 -0700, Andrew Morton wrote:
> On Fri, 04 Aug 2006 17:04:59 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > On Thu, 2006-08-03 at 22:53 -0700, Andrew Morton wrote:
> > > VMI is being proposed as an appropriate way to connect Linux to Xen.  If
> > > that is true then no other glue is needed.
> > 
> > Sorry, this is wrong.
> 
> It's actually 100% correct.

Err, yes.  I actually misrepresented VMI: the native implementation is
inline (ie. no blob is required for native).  Bad Rusty.

> > > > Yes, we could force native and Xen to work via VMI, but the result would
> > > > be less clear, less maintainable, and gratuitously different from
> > > > elsewhere in the kernel.
> > > 
> > > I suspect others would disagree with that.  We're at the stage of needing
> > > to see code to settle this.
> > 
> > Wrong again.
> 
> I was referring to the VMI-for-Xen code.

I know.  And I repeat, we don't have to see that part, to know that the
result is less clear, less maintainable and gratuitously different from
elsewhere in the kernel than the paravirt_ops approach.  We've seen
paravirt and the VMI parts of this already.

> >  We've *seen* the code for VMI, and fairly hairy.
> 
> I probably slept through that discussion - I don't recall that things were
> that bad.   Do you recall the Subject: or date?

Read the patches which Zach sent back in March, particularly:

[RFC, PATCH 3/24] i386 Vmi interface definition
[RFC, PATCH 4/24] i386 Vmi inline implementation
[RFC, PATCH 5/24] i386 Vmi code patching

If you want to hack on x86 arch code, you'd need to understand these.

Then to see the paravirt patches go to http://ozlabs.org/~rusty/paravirt
and look at the approximately-equivalent paravirt_ops patches:

	008-paravirt-structure.patch
	009-binary-patch.patch

There's nothing in those paravirt_ops patches which will surprise any
kernel hacker.  That's my entire point: maintainable, unsurprising,
clear.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

