Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312532AbSCYUCM>; Mon, 25 Mar 2002 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312534AbSCYUCC>; Mon, 25 Mar 2002 15:02:02 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:41633 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S312532AbSCYUBo>;
	Mon, 25 Mar 2002 15:01:44 -0500
Date: Mon, 25 Mar 2002 15:01:30 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Peter Hartley <PDHartley@sonicblue.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Support __NR_ugetrlimit for 2.2 kernel (Re: Does e2fsprogs-1.26 work on mips?)
Message-ID: <20020325150130.A17464@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	Peter Hartley <PDHartley@sonicblue.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
In-Reply-To: <37D1208A1C9BD511855B00D0B772242C011C7F15@corpmail1.sc.sonicblue.com> <20020325111117.A15661@lucon.org> <20020325114511.A16225@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 11:45:11AM -0800, H . J . Lu wrote:
> On Mon, Mar 25, 2002 at 11:11:17AM -0800, H . J . Lu wrote:
> > On Mon, Mar 25, 2002 at 11:00:05AM -0800, Peter Hartley wrote:
> > > H J Lu wrote:
> > > > What are you talking about? It doesn't matter which kernel header
> > > > is used. glibc doesn't even use /usr/include/asm/resource.h nor
> > > > should any user space applications.
> > > 
> > > It's not about /usr/include/asm/resource.h, it's about
> > > /usr/include/asm/unistd.h, where the syscall numbers are defined.
> > > 
> > > This is presumably what the "#ifdef __NR_ugetrlimit" in
> > > sysdeps/unix/sysv/linux/i386/getrlimit.c is meant to be testing against --
> > > nothing in the glibc-2.2.5 distribution itself defines that symbol. Surely a
> > > Linux glibc doesn't compile without the target system's linux/* and asm/*
> > > headers?
> > > 
> > > 2.4's /usr/include/asm/unistd.h defines __NR_ugetrlimit but 2.2's doesn't.
> > > 
> > 
> > I see. I think glibc should either require 2.4 header files under
> > <asm/*.h> and <linux/*.h>, or define __NR_ugetrlimit if it is not
> > defined.
> > 
> > 
> 
> How about this patch?


Just require 2.4 kernel headers if you want to work under a 2.4 kernel. 
It may not have been documented/enforced, but I believe this was
already true.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
