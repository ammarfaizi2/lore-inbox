Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWI1ToV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWI1ToV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWI1ToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:44:21 -0400
Received: from colin.muc.de ([193.149.48.1]:525 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751486AbWI1ToU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:44:20 -0400
Date: 28 Sep 2006 21:44:18 +0200
Date: Thu, 28 Sep 2006 21:44:18 +0200
From: Andi Kleen <ak@muc.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-ID: <20060928194418.GA51533@muc.de>
References: <451B64E3.9020900@goop.org> <20060927233509.f675c02d.akpm@osdl.org> <451B708D.20505@goop.org> <20060928000019.3fb4b317.akpm@osdl.org> <20060928071731.GB84041@muc.de> <20060928002610.05e61321.akpm@osdl.org> <20060928101555.GA99906@muc.de> <451BA434.9020409@goop.org> <20060928103853.GB99906@muc.de> <Pine.LNX.4.64.0609281626001.25939@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281626001.25939@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:30:19PM +0100, Hugh Dickins wrote:
> On Thu, 28 Sep 2006, Andi Kleen wrote:
> > On Thu, Sep 28, 2006 at 03:30:12AM -0700, Jeremy Fitzhardinge wrote:
> > > Andi Kleen wrote:
> > > >But no out of line section. So overall it's smaller, although the cache 
> > > >footprint
> > > >is 2 bytes larger. But then is 2 bytes larger really an issue? We don't 
> > > >have
> > > >_that_ many BUGs anyways.
> > > >  
> > > 
> > > I think the out of line section is a feature; no point in crufting up 
> > > the icache with BUG gunk, especially since a number of them are on 
> > > fairly hot paths.
> > 
> > It's 10 bytes per BUG. 
> 
> Or 9 bytes per BUG: I protested about the disassembly problem back
> when the minimized BUG() first went in, and have been using "ljmp"
> in my i386 builds ever since:

Good point.

Need to check if that works on x86-64 too. 

-Andi
