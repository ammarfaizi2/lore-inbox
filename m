Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbRETSB4>; Sun, 20 May 2001 14:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbRETSBq>; Sun, 20 May 2001 14:01:46 -0400
Received: from imladris.infradead.org ([194.205.184.45]:40457 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S261409AbRETSB1>;
	Sun, 20 May 2001 14:01:27 -0400
Date: Sun, 20 May 2001 19:01:22 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Peter Zaitsev <pz@spylog.ru>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4 folks
In-Reply-To: <24243045671.20010519105201@spylog.ru>
Message-ID: <Pine.LNX.4.33.0105201856400.16275-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

 > I've trying to move some of my servers to 2.4.4 kernel from
 > 2.2.x. Everything goes fine, notable perfomance increase
 > occures, but the problem is I'm really often touch the following
 > problem:

 > __alloc_pages: 1-order allocation failed.
 > __alloc_pages: 1-order allocation failed.
 > __alloc_pages: 1-order allocation failed.
 > __alloc_pages: 1-order allocation failed.
 > __alloc_pages: 1-order allocation failed.

 > This message may also show 1-order, 0-order, 3-order failures
 > (only one type at the time).  This problems also appeared then I
 > tried to use 2.4.1-2.4.3 kernels.

 > This sometimes leads to system hang, sometimes some processes
 > gets unkillable (even by kill -9) and in some cases I do not see
 > any bad results from this, but still this does not looks the
 > right thing to happen.

 > The problem is the systems this happens on are not short of
 > memory. Here is the free output for the system I had this
 > happened this morning:

 > rat:~ #  free

 > Mem:       1028628    1025820       2808          0       9340     332412
 > -/+ buffers/cache:     684068     344560
 > Swap:      2097136          0    2097136

 > Does anyone has any ideas about this problem ?

I'm not up to date with the 2.4 series at the moment, but...

Looking at the figures you're showing, this looks like you have 1024M
of RAM. It used to be necessary to recompile the kernel if you had
more than (going from memory) 976M of RAM, where you had to change a
configuration option to select 2G of paging space instead of the
default 3G thereof, and this looks suspiciously like this problem to
me.

Can anybody confirm whether this limitation still applies?

Best wishes from Riley.

