Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTKQRbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTKQRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:31:35 -0500
Received: from citi.umich.edu ([141.211.133.111]:54155 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S263609AbTKQRbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:31:33 -0500
Date: Mon, 17 Nov 2003 12:31:31 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: <rroesler@syskonnect.de>, <mlindner@syskonnect.de>,
       David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with syskonnect card with 2.4.23-pre kernels (fwd)
Message-ID: <Pine.BSO.4.33.0311171226420.7739-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

originally i sent these to mirko without looking at the MAINTAINERS file.
mea culpa.

---------- Forwarded message ----------
Date: Fri, 14 Nov 2003 18:39:51 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: mlindner@syskonnect.de
Subject: Re: problems with syskonnect card with 2.4.23-pre kernels

another couple of data points:

i've pulled changesets 1.1148.17.2, 1.1120.11.16, 1.1120.11.15, and
1.1063.2.72 off of 2.4.23-pre9, and i am no longer able to reproduce the
crashes on one of my SysKonnect-attached systems (haven't tried the other
one yet).

this system is running fedora core 1.  the 2.4.22-blah kernel that
comes with fedora is using v6.15 of the sk98lin driver without
difficulties, btw.

On Fri, 14 Nov 2003, Chuck Lever wrote:

> hi-
>
> i have two SMP systems with Syskonnect GbE cards (other similar systems
> also with NetGear, etc, do not see these problems).
>
> after upgrading these to 2.4.23-pre9, the Syskonnect systems crash after a
> little bit of network activity (incoming sshd connections, outgoing
> telnet, and so on, but not NFS client activity, oddly).
>
> there is an oops first, at the skbuff.c:92 BUG(), then the system panics.
> i'm still trying to capture more information about the problem, but the
> oops and panic do not leave kernel log trails, and the panic prevents
> console scrollback.  maybe serial console is the next step.
>
> i suspect the sk98lin driver because a) it changed in 2.4.23-pre3 and
> -pre7, and b) the other systems are almost identical except for their
> NICs, and do not exhibit this problem.
>
> any specific advice about how to debug this, or have you already seen this
> problem?
>
> card info from lspci -v:
>
> 01:02.0 Ethernet controller: Syskonnect (Schneider & Koch) Gigabit
> Ethernet (rev 13)
>         Subsystem: Syskonnect (Schneider & Koch) SK-9821 (1000Base-T
> single link)
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 27
>         Memory at febfc000 (32-bit, non-prefetchable) [size=16K]
>         I/O ports at e800 [size=256]
>         Expansion ROM at febc0000 [disabled] [size=128K]
>         Capabilities: [48] Power Management version 1
>         Capabilities: [50] Vital Product Data
>
> the systems are dual P-III systems using serverworks LE and HE chipsets.
> one has 1GB of memory, the other 256MB of memory.
>
> 	- Chuck Lever
> --
> corporate:	<cel at netapp dot com>
> personal:	<chucklever at bigfoot dot com>
>
>

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>


