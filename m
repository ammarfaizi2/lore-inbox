Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbTCLVuW>; Wed, 12 Mar 2003 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbTCLVuW>; Wed, 12 Mar 2003 16:50:22 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:65344 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261791AbTCLVuV>; Wed, 12 Mar 2003 16:50:21 -0500
Date: Wed, 12 Mar 2003 22:54:05 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.44.0303121032001.15671-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.30.0303122242180.18833-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Linus Torvalds wrote:
>
> The difficulty is finidng the right instruction boundary. It's basically
> impossible.

If I understand you correctly, no. We have the boundary at EIP.
Decoding what's before is max 7-8 tries by a human and one can figure
out the real code from the context (with high probability). 2-3 times
more code before EIP then after could significantly help of course.

> If you want to get the instructions before that point, just use
>
> 	gdb vmlinux

This approach frequently fails because vmlinux is on a users computer
far away and he

  1) doesn't bother answering anymore
  2) recompiled with different .config
  3) reinstalled another distro
  4) etc

> and disassemble it by hand. Because the kernel _cannot_ do it reliably.

The kernel shouldn't do it, it's not disassembler. It should just give
enough data for a human and disassembler. Nothing lost but much can be
gain.

	Szaka

