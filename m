Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbRF2RPk>; Fri, 29 Jun 2001 13:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbRF2RPU>; Fri, 29 Jun 2001 13:15:20 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:23541 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266121AbRF2RPR>; Fri, 29 Jun 2001 13:15:17 -0400
Message-Id: <4.3.1.0.20010629101231.00e56780@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Fri, 29 Jun 2001 10:14:52 -0700
To: Andrew Morton <andrewm@uow.edu.au>,
        Andreas Schuldei <andreas@schuldei.org>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: artificial latency for a network interface
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B3C0060.FBDB5F87@uow.edu.au>
In-Reply-To: <20010629003900.A6065@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I wanted to do that using two tun devices.
> > I had hoped to have a routing like this:
> > 
> >  <-> eth0 <-> tun0 <-> userspace, waiting queue <-> tun1 <-> eth1
>
>yes, that works very well.  A userspace app sits on top of the
>tun/tap device and pulls out packets, delays them and reinjects
>them.
Right. And you don't even need tun1. Just write them back to tun0.

>The problem is routing: when you send the packet back to the
>kernel, it sends it straight back to you.  You need to rewrite
>the headers, which is a pain.
True.

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

