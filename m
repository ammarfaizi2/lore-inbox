Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSCYRHv>; Mon, 25 Mar 2002 12:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312466AbSCYRHm>; Mon, 25 Mar 2002 12:07:42 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:12783 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S312460AbSCYRH2>; Mon, 25 Mar 2002 12:07:28 -0500
Date: Mon, 25 Mar 2002 09:07:17 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Peter Hartley <PDHartley@sonicblue.com>
Cc: Andrew Morton <akpm@zip.com.au>, tytso@thunk.org, linux-mips@oss.sgi.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020325090717.A13707@lucon.org>
In-Reply-To: <37D1208A1C9BD511855B00D0B772242C011C7F13@corpmail1.sc.sonicblue.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 02:52:24AM -0800, Peter Hartley wrote:
> H J Lu wrote:
> > I look at the glibc code. It uses a constant RLIM_INFINITY for a given
> > arch. The user always passes (~0UL) to glibc on x86. glibc will check
> > if the kernel supports the new getrlimit at the run time. If it
> > doesn't, glibc will adjust the RLIM_INFINITY for setrlimit. I 
> > don't see
> > how glibc 2.2.5 compiled under kernel 2.2 will fail under 2.4 due to
> > this unless glibc is misconfigureed or miscompiled.
> 
> It's not a question of which kernel glibc is compiled under, it's a question
> of which version of the kernel headers (/usr/include/{linux,asm}) glibc is
> compiled against.
> 

What are you talking about? It doesn't matter which kernel header
is used. glibc doesn't even use /usr/include/asm/resource.h nor
should any user space applications.



H.J.
