Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRCNT4R>; Wed, 14 Mar 2001 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRCNT4H>; Wed, 14 Mar 2001 14:56:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64918 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131512AbRCNTzy>;
	Wed, 14 Mar 2001 14:55:54 -0500
Date: Wed, 14 Mar 2001 14:55:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.30.0103142143300.13864-100000@fs131-224.f-secure.com>
Message-ID: <Pine.GSO.4.21.0103141451310.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Szabolcs Szakacsits wrote:

> 
> On Mon, 12 Mar 2001, Alexander Viro wrote:
> > On Mon, 12 Mar 2001, Guennadi Liakhovetski wrote:
> > > I need to collect some info on processes. One way is to read /proc
> > > tree. But isn't there a system call (ioctl) for this? And what are those
> > Occam's Razor.  Why invent new syscall when read() works?
> 
> read() doesn't really work for this purpose, it blocks way too many
> times to be very annoying. When finally data arrives it's useless.

Huh? Take code of your non-blocking syscall. Make it ->read() for
relevant file on /proc or wherever else you want it. See read() not
blocking...

Whether code blocks or not depends on the code, not on the calling
conventions. And definitely not on ASCII vs. binary - conversion
between these formats _is_ doable without blocking operations.

