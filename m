Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132880AbRDEMd6>; Thu, 5 Apr 2001 08:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132878AbRDEMdv>; Thu, 5 Apr 2001 08:33:51 -0400
Received: from rdu163-40-153.nc.rr.com ([24.163.40.153]:18443 "EHLO
	kaitan.hacknslash.net") by vger.kernel.org with ESMTP
	id <S132880AbRDEMdX>; Thu, 5 Apr 2001 08:33:23 -0400
Date: Thu, 5 Apr 2001 08:32:36 -0400 (EDT)
From: Jeff Layton <jtlayton@bigfoot.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols on SPARC with depmod -ae
In-Reply-To: <15052.25810.619907.25595@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0104050830420.26901-100000@kaitan.hacknslash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep the module loaded fine. Must be a problem with depmod then. Thanks for
the info!

caladan:~# modprobe ip_conntrack
caladan:~# lsmod
Module                  Size  Used by
ip_conntrack           19840   0  (unused)

--
Jeff Layton (jtlayton@bigfoot.com)

    "In order for you to profit from your mistakes, you have to get out and
     make some."
        -- Anonymous

On Thu, 5 Apr 2001, David S. Miller wrote:

> 
> Jeff Layton writes:
>  > Anyway here's what I get, should I be concerned about this?
> ...
>  > caladan:~# /sbin/depmod -ae -F /boot/System.map-2.4.2
>  > depmod: *** Unresolved symbols in
>  > /lib/modules/2.4.2/kernel/drivers/block/loop.o
>  > depmod:         .div
>  > depmod:         .urem
>  > depmod:         .umul
>  > depmod:         .udiv
>  > depmod:         .rem
>  > depmod: *** Unresolved symbols in
> 
> Try to load one of the modules which show the problem, does
> it work?  If so, it is a bug in depmod's handling of these
> ".foo" symbols.
> 
> Later,
> David S. Miller
> davem@redhat.com
> 

