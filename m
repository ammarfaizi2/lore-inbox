Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSL1Tbn>; Sat, 28 Dec 2002 14:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSL1Tbn>; Sat, 28 Dec 2002 14:31:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266292AbSL1Tbm>; Sat, 28 Dec 2002 14:31:42 -0500
Date: Sat, 28 Dec 2002 11:34:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address space
In-Reply-To: <200212281547.KAA02128@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0212281131480.2812-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Dec 2002, Jeff Dike wrote:
> This is a large patch, but
> 	it's all under arch/um and include/asm-um
> 	a lot of it is code movement

Pulled, but that /proc/mm crap has to go (it wasn't in this patch, or I 
would have rejected it). 

What are the semantics the host code wants/needs, and how can we implement
a sane generic mechanism that doesn't involve opening magic files?

Having co-processes isn't wrong in itself, I just want the support to be 
clean and generic, instead of a huge hack.

		Linus

