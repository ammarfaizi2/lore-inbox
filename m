Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUE0MTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUE0MTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUE0MTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:19:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262006AbUE0MTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:19:06 -0400
Date: Thu, 27 May 2004 09:20:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vincent Lefevre <vincent@vinc17.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040527122042.GC13095@logos.cnet>
References: <20040509001045.GA23263@ay.vinc17.org> <Pine.LNX.4.53.0405082142100.25076@chaos> <20040509022043.GE23263@ay.vinc17.org> <20040509140611.28e4b2bf.pj@sgi.com> <20040509214941.GG7161@ay.vinc17.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040509214941.GG7161@ay.vinc17.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 11:49:41PM +0200, Vincent Lefevre wrote:
> On 2004-05-09 14:06:11 -0700, Paul Jackson wrote:
> > Vincent wrote:
> > > NULL == (void *) 0 and NULL == 0 must be true
> > Yes - NULL is compares equal to both (void *)0 and 0.
> > No - not necessarily the _same_ value - one could be
> > on a system with 32 bit ints, 64 bit pointers, for example.
> 
> And so?
> 
> > > The goal of malloc is to reserve memory.
> > It's up to the kernel whether sbrk (used by malloc to
> > obtain virtual address space) reserves memory or not.
> 
> More old_mmap than brk (BTW, I forgot to say that this was on
> an x86 machine, I don't know if this matters...).
> 
> > Check out:
> >     /proc/sys/vm/overcommit_memory
> >     Documentation/sysctl/vm.txt - overcommit_memory
> 
> But the documentation is wrong (on an official 2.4.26 kernel).
> It seems that there is no way to get malloc() always return 0
> when there isn't enough memory, even in simple cases (see my
> program posted in the first message).

Right. 

We should or merge Alan's strict-overcommit patches (from RH's tree), 
or fix the documentation.

Marc-Christian Petersen has a patch to fixup the documentation.
