Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTIJPmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTIJPmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:42:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63118 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265080AbTIJPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:42:44 -0400
Subject: Re: NFS/MOUNT/sunrpc problem?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com>
References: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063208491.32726.66.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 16:41:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 15:37, Marco Bertoncin - Sun Microsystems UK -
Platform OS Development Engineer wrote:
> - PXE booting x86 'headless' blades (2.0 Ghz 2P Xeon) to install RedHat 8.0 
> (kernel 2.4.18).

Update the kernel once installed, the 2.4.18- kernels are obsoleted by
other security fixes

> - the blade, after 3 seconds, starts a storm of retransmit (MOUNT reqs) that 
> won't stop, unless an ACK (one of the several ACKS sent for each retransmitted 
> requests) has the chance to get through. This is sometimes after a few hundreds 
> packets, sometimes after a lot more, causing an apparent hang of the 
> installation process, and what's even worse, bringing to a grinding halt the  
> server (bombarded by near 1Gbit/sec packets).

I've seen one other report of this (with a via chip),

> Ah, one last experiment I did was to try and reproduce the problem on an 
> installed blade (same version of the kernel). No chance. I noticed, though that 
> the MOUNT request sent by the 'installed linux' (it would be a proper i686-smp 
> build instead of a up i386) is V3, whilst that during installation is V2. 
> Thinking this might have been a hunch, I tried "mount -o nfsvers=2 
> server:/export /mnt": I saw the requests, the dropped ack (on the server side, 
> of course) but no storm ...!).

Are you using NFS root or just NFS mounts ?


