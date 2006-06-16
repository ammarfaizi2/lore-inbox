Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWFPP62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWFPP62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWFPP62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:58:28 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:1444 "EHLO
	sunsite.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751473AbWFPP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:58:27 -0400
Date: Fri, 16 Jun 2006 17:58:04 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Message-ID: <20060616155804.GN3823@sunsite.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200606140942.31150.ak@suse.de> <200606161656.40930.ak@suse.de> <4492CEC0.2080102@bull.net> <200606161737.06132.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606161737.06132.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 05:37:06PM +0200, Andi Kleen wrote:
> On Friday 16 June 2006 17:31, Zoltan Menyhart wrote:
> > Andi Kleen wrote:
> > 
> > > That is not how user space TLS works. It usually has a base a register.
> > 
> > Can you please give me a real life (simplified) example?
> 
> On x86-64 it's just %fs:offset. gcc is a bit dumb on this and usually
> loads the base address from %fs:0 first.

GCC is not dumb, unless you force it with -mno-tls-direct-seg-refs.
Guess you are bitten by SUSE GCC hack which makes -mno-tls-direct-seg-refs
the default (especially on x86-64 it is a really bad idea).

	Jakub
