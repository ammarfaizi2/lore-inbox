Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWIPGT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWIPGT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWIPGT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:19:56 -0400
Received: from colin.muc.de ([193.149.48.1]:23052 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932204AbWIPGTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:19:55 -0400
Date: 16 Sep 2006 08:19:54 +0200
Date: Sat, 16 Sep 2006 08:19:54 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Jarek Poplawski <jarkao2@o2.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060916061954.GA31366@muc.de>
References: <20060913065010.GA2110@ff.dom.local> <20060914181754.bd963f6d.akpm@osdl.org> <20060915081123.GA2572@ff.dom.local> <20060915012302.d459c2dc.akpm@osdl.org> <20060915152349.GA22233@redhat.com> <20060915123340.fd01fec4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915123340.fd01fec4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:33:40PM -0700, Andrew Morton wrote:
> On Fri, 15 Sep 2006 11:23:49 -0400
> Dave Jones <davej@redhat.com> wrote:
> 
> > On Fri, Sep 15, 2006 at 01:23:02AM -0700, Andrew Morton wrote:
> > 
> >  > > > Thanks.   Andi has already queued a similar patch.
> >  > > > 
> >  > > > Andi, you might as well scoot that upstream, otherwise we'll get lots of
> >  > > > emails about it.
> >  > > ...
> >  > > > > +#if 0xFF >= MAX_MP_BUSSES
> >  > > > >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
> >  > > I don't know how Andi has fixed it,
> >  > Same thing.  (He has `#if MAX_MP_BUSSES < 256').
> > 
> > How can this be the right the right thing to do ?
> > It should *never* be >=256. mach-summit/mach-generic need fixing
> > to be 255, not this ridiculous band-aid.  Where did 260 come from anyway?
> >  
> 
> commit f0bacaf5cec4e677a00b5ab06d95664d03a30f7a
> Author: akpm <akpm>
> Date:   Mon Apr 12 20:06:32 2004 +0000
> 
>     [PATCH] summmit: increase MAX_MP_BUSSES
>     
>     From: James Cleverdon <jamesclv@us.ibm.com>
>     
>     Bump up MAX_MP_BUSSES for summit/generic subarch to cope with big IBM x440
>     systems.

The 260 is because ACPI can create larger busses and the summit
boxes only run with ACPI anyways.

-Andi
