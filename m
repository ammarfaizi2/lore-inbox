Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbTCGSoI>; Fri, 7 Mar 2003 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbTCGSoI>; Fri, 7 Mar 2003 13:44:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261717AbTCGSoG>; Fri, 7 Mar 2003 13:44:06 -0500
Date: Fri, 7 Mar 2003 10:52:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303071929010.5042-100000@serv>
Message-ID: <Pine.LNX.4.44.0303071046440.1606-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Roman Zippel wrote:
> 
> Could you please repeat your reasoning? I must have missed something.

The reasoning is very simple:

 - klibc is small. It would be pointless to make it a shared library, 
   because the infrastructure to do so and the indirection required would
   likely be bigger than klibc itself (unless klibc is eventually bloated
   up)

 - klibc is potentially useful outside just standard kernel initrd images,
   and in fact for development it is nice to use it that way.

Put the two together, and the GPL really doesn't look like a very good 
license for klibc. Yeah, you can disagree about what the actual exceptions 
are, but clearly there has to be _some_ exception to the license.

Also, since the kernel GPL thing doesn't taint user space apps (very much 
documented since day 1), there really isn't any _reason_ to use the GPL in 
the first place. klibc wouldn't ever get linked into the kernel, only into 
apps.

As such, and since Peter is the main author, I don't see your argument, 
Roman.

		Linus

