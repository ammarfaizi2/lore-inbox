Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbTCLSZK>; Wed, 12 Mar 2003 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTCLSZK>; Wed, 12 Mar 2003 13:25:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261841AbTCLSZJ>; Wed, 12 Mar 2003 13:25:09 -0500
Date: Wed, 12 Mar 2003 10:33:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303121833530.18833-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0303121032001.15671-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> 
> The Code part of the Oops shows what's after EIP (i386). It's also
> important (if not more) what's before. I fail to see the difficulties
> to add this feature (or was it dropped?), ksymoops should handle it.

The difficulty is finidng the right instruction boundary. It's basically 
impossible.

If you want to get the instructions before that point, just use

	gdb vmlinux

and disassemble it by hand. Because the kernel _cannot_ do it reliably.

		Linus

