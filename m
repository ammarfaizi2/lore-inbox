Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWFPQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWFPQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWFPQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:25:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:50145 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751479AbWFPQZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:25:07 -0400
From: Andi Kleen <ak@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 18:24:52 +0200
User-Agent: KMail/1.9.3
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161737.06132.ak@suse.de> <20060616155804.GN3823@sunsite.mff.cuni.cz>
In-Reply-To: <20060616155804.GN3823@sunsite.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161824.52620.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 17:58, Jakub Jelinek wrote:
> On Fri, Jun 16, 2006 at 05:37:06PM +0200, Andi Kleen wrote:
> > On Friday 16 June 2006 17:31, Zoltan Menyhart wrote:
> > > Andi Kleen wrote:
> > > 
> > > > That is not how user space TLS works. It usually has a base a register.
> > > 
> > > Can you please give me a real life (simplified) example?
> > 
> > On x86-64 it's just %fs:offset. gcc is a bit dumb on this and usually
> > loads the base address from %fs:0 first.
> 
> GCC is not dumb, unless you force it with -mno-tls-direct-seg-refs.
> Guess you are bitten by SUSE GCC hack which makes -mno-tls-direct-seg-refs
> the default (especially on x86-64 it is a really bad idea).

I apparently got indeed.

I wonder why it happened on x86-64 though - i thought there were no negative
offsets on x86-64 TLS.

-Andi
