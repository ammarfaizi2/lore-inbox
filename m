Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWIOPYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWIOPYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIOPYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:24:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65427 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751493AbWIOPYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:24:13 -0400
Date: Fri, 15 Sep 2006 11:23:49 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jarek Poplawski <jarkao2@o2.pl>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060915152349.GA22233@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Jarek Poplawski <jarkao2@o2.pl>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20060913065010.GA2110@ff.dom.local> <20060914181754.bd963f6d.akpm@osdl.org> <20060915081123.GA2572@ff.dom.local> <20060915012302.d459c2dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915012302.d459c2dc.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 01:23:02AM -0700, Andrew Morton wrote:

 > > > Thanks.   Andi has already queued a similar patch.
 > > > 
 > > > Andi, you might as well scoot that upstream, otherwise we'll get lots of
 > > > emails about it.
 > > ...
 > > > > +#if 0xFF >= MAX_MP_BUSSES
 > > > >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
 > > I don't know how Andi has fixed it,
 > Same thing.  (He has `#if MAX_MP_BUSSES < 256').

How can this be the right the right thing to do ?
It should *never* be >=256. mach-summit/mach-generic need fixing
to be 255, not this ridiculous band-aid.  Where did 260 come from anyway?
 
	Dave 
