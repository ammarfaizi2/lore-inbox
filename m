Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312503AbSCYTLr>; Mon, 25 Mar 2002 14:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSCYTLh>; Mon, 25 Mar 2002 14:11:37 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:33272 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S312503AbSCYTLX>; Mon, 25 Mar 2002 14:11:23 -0500
Date: Mon, 25 Mar 2002 11:11:17 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Peter Hartley <PDHartley@sonicblue.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020325111117.A15661@lucon.org>
In-Reply-To: <37D1208A1C9BD511855B00D0B772242C011C7F15@corpmail1.sc.sonicblue.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 11:00:05AM -0800, Peter Hartley wrote:
> H J Lu wrote:
> > What are you talking about? It doesn't matter which kernel header
> > is used. glibc doesn't even use /usr/include/asm/resource.h nor
> > should any user space applications.
> 
> It's not about /usr/include/asm/resource.h, it's about
> /usr/include/asm/unistd.h, where the syscall numbers are defined.
> 
> This is presumably what the "#ifdef __NR_ugetrlimit" in
> sysdeps/unix/sysv/linux/i386/getrlimit.c is meant to be testing against --
> nothing in the glibc-2.2.5 distribution itself defines that symbol. Surely a
> Linux glibc doesn't compile without the target system's linux/* and asm/*
> headers?
> 
> 2.4's /usr/include/asm/unistd.h defines __NR_ugetrlimit but 2.2's doesn't.
> 

I see. I think glibc should either require 2.4 header files under
<asm/*.h> and <linux/*.h>, or define __NR_ugetrlimit if it is not
defined.


H.J.
