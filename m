Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQKGLGt>; Tue, 7 Nov 2000 06:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbQKGLGk>; Tue, 7 Nov 2000 06:06:40 -0500
Received: from [62.172.234.2] ([62.172.234.2]:64422 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130108AbQKGLGW>;
	Tue, 7 Nov 2000 06:06:22 -0500
Date: Tue, 7 Nov 2000 11:06:22 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>,
        Catalin BOIE <util@deuroconsult.ro>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <20001106182059.G12348@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0011071104430.1698-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Erik Mouw wrote:

> On Mon, Nov 06, 2000 at 10:11:11AM -0500, Michael Vines wrote:
> > On Mon, 6 Nov 2000, Erik Mouw wrote:
> > > Use LD_PRELOAD instead.
> > 
> > You could also write a simple kernel module that replaces the open system
> > call.  See the Linux Kernel Module Programming Guide for details. 
> > http://www.linuxdoc.org/guides.html
> > 
> > specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html
> 
> Why difficult when it can be done easy? To test the Y2K readiness of
> some programs (yeah, Y2K, remember?), I wrote a small library that
> overloaded the time() and gettimeofday() syscalls in about 100 lines of
> code. No kernel modules needed, no root privileges needed, just set the
> environment variable LD_PRELOAD and off you go.

To test Y2k readiness of programs one simply can use my timetravel kernel
module. No, doing things in userspace is far more complex and less
reliable and also simply not good enough (because doesn't cover the case
of statically-linked binaries):

http://www.ocston.org/~tigran/tt/tt.html

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
