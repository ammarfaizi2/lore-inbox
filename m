Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310158AbSCPIO3>; Sat, 16 Mar 2002 03:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCPIOS>; Sat, 16 Mar 2002 03:14:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27659 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310158AbSCPIOJ>; Sat, 16 Mar 2002 03:14:09 -0500
Date: Sat, 16 Mar 2002 00:13:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH] devexit fixes in i82092.c 
In-Reply-To: <15271.1016265111@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0203160010510.2448-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Keith Owens wrote:
>
> Does that mean that we also get rid of the initcall methods?  If
> shutdown follows a device tree then startup should also use that tree.

You cannot _build_ the tree without the initcall methods - it's populating
the tree that the initcalls mostly do, after all.

We could make one of the methods be "startup", of course, and move the
actual device initialization there (and leave just the "find driver" in
the initcall logic), but that would not get rid of the initcalls, it would
just split them into two parts.

		Linus

