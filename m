Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTHSRgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTHSRf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:35:59 -0400
Received: from [63.247.75.124] ([63.247.75.124]:49858 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272791AbTHSR0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:26:52 -0400
Date: Tue, 19 Aug 2003 13:26:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030819172651.GA15781@gtf.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <3F4120DD.3030108@softhome.net> <20030818190421.GN24693@gtf.org> <200308190832.24744.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308190832.24744.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 08:32:24AM -0400, Rob Landley wrote:
> On Monday 18 August 2003 15:04, Jeff Garzik wrote:
> 
> > >    But generally idea is good: keep interface separately from
> > > implementation.
> >
> > No, the idea is to physically separate the headers.
> >
> > include/{linux,asm} is currently copied to userspace, hacked a bit,
> > and then shipped as the "glibc-kernheaders" package.
> 
> Or used directly by uclibc (and linux from scratch) to build the library 
> against.

Yes, this is incorrect.

Kernel developers have been telling people for years, "do not directly
include kernel headers."


> > I would rather that the kernel developers directly maintained this
> > interface, by updating headers in include/abi, rather than ad-hoc by
> > distro people.
> >
> > 	Jeff
> 
> Okay, I'd like to ask about the headers thing:
> 
> I've got a project using uclibc, and build it myself, currently against the 
> 2.4 headers.  What's the plan for 2.6?  Everything I've seen on the subject 
> is "using kernel headers directly from userspace is evil, even to build your 
> libc against, but we currently offer no alternative, so go bug your libc 
> maintainer and have THEM do it..."

Well, do you expect kernel developers to fix up every libc out there?
That's what libc maintainers exist for.  Distro guys did glibc,
(glibc-kernheaders) that covers the majority.

In any case, _this thread_ is an attempt to answer your question,
"what's the plan?"  For 2.6, I don't need include/abi happening.  Way
too late for that.  For 2.7, IMO we need it...

	Jeff



