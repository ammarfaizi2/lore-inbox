Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJNVyl>; Mon, 14 Oct 2002 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVyl>; Mon, 14 Oct 2002 17:54:41 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:42903 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262198AbSJNVyk>; Mon, 14 Oct 2002 17:54:40 -0400
Message-Id: <5.1.0.14.2.20021014144731.083a56f0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Oct 2002 15:00:12 -0700
To: Alexander Viro <viro@math.psu.edu>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [PATCH] Export sockfd_lookup function
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.GSO.4.21.0210141700010.6505-100000@weyl.math.psu.edu>
References: <5.1.0.14.2.20021014134001.083de250@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:01 PM 10/14/2002 -0400, Alexander Viro wrote:


>On Mon, 14 Oct 2002, Maksim (Max) Krasnyanskiy wrote:
>
> >
> > Can we export sockfd_lookup function ?
> > I need it in one of the Bluetooth modules which has to look up 'struct 
> socket'
> > from fd in the ioctl handler.
>
>What the hell does that ioctl do with file descriptors in the first place?
What is so unusual in dealing with file descriptors in ioctl ?

Anyway, that ioctl takes file descriptor, finds struct socket and starts 
kernel
thread, struct socket is then used in that kernel thread 
(sock->ops->sendmsg, etc).
Take a look in net/bluetooth/bnep/sock.c:bnep_sock_ioctl() if you're 
interested.

Max

