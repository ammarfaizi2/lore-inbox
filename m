Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263650AbSJGWeK>; Mon, 7 Oct 2002 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263652AbSJGWeK>; Mon, 7 Oct 2002 18:34:10 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:51604 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S263650AbSJGWeE>; Mon, 7 Oct 2002 18:34:04 -0400
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>
In-Reply-To: <Pine.LNX.4.33.0210071426480.1402-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0210071426480.1402-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Oct 2002 00:38:44 +0200
Message-Id: <1034030338.10265.4.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 23:28, Linus Torvalds wrote:
> 
> On 7 Oct 2002, Marcel Holtmann wrote:
> > 
> > but when I try to compile in the Bluetooth subsystem I got the following
> > error:
> > 
> > net/built-in.o: In function `sock_init':
> > net/built-in.o(.text.init+0x5b): undefined reference to `bluez_init'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> This is a separate error, apparently because net/socket.c calls 
> "blues_init()" if bluetooth is configured in.
> 
> That shouldn't be needed at all, since the "init_module()" thing should 
> take care of it. Please try just removing the bluez_init references from 
> net/socket.c - that should fix the compile, and if all the ordering issues 
> are ok, it should also work afterwards..

I started a clean build kernel without this code and it works. Thanks
for the info and a new patch follows.

Regards

Marcel


