Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUKJAp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUKJAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKJAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:45:26 -0500
Received: from ozlabs.org ([203.10.76.45]:51426 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261811AbUKJApR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:45:17 -0500
Subject: Re: insmod module-loading errors, Linux-2.6.9
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-os@analogic.com, Valdis.Kletnieks@vt.edu,
       Colin Leroy <colin.lkml@colino.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <419106C1.40809@sun.com>
References: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
	 <Pine.LNX.4.61.0411090745160.11563@chaos.analogic.com>
	 <419106C1.40809@sun.com>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 10:37:53 +1100
Message-Id: <1100043473.25963.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 13:04 -0500, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> linux-os wrote:
> > On Mon, 8 Nov 2004 Valdis.Kletnieks@vt.edu wrote:
> > 
> >> On Mon, 08 Nov 2004 12:52:18 EST, linux-os said:
> >>
> >>> There are certainly work-arounds for problems that shouldn't
> >>> exist at all. So, every time I do something to a kernel, I
> >>> have to change whatever the EXTRAVERSION field is?  Then, when
> >>> a customer demands that the kernel version be exactly the
> >>> same that was shipped with Fedora or whatever, I'm screwed.
> >>
> >>
> >> If you didn't have the foresight to keep that kernel version around,
> >> there isn't much we can do to help you.  Yes, this may mean you have
> >> a big bunch of /usr/src/linux-2.6.* directories.
> >>
> > 
> > Wrong. Whoever put the module-loading code INSIDE the kernel,
> > for POLITICAL reasons, created a new POLICY.
> > 
> 
> No.  Version information is still stripped in module-init-tools in
> _userspace_ for modprobe --force.  The fact that insmod doesn't support
> '-f' is probably an oversight and Rusty would likely accept a patch.

Hmm, insmod is actually designed to be a minimal system call wrapper
(ie. most people probably shouldn't be using it).  However, it accepts
standard input and objcopy will happily strip sections out of a module.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

