Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbSLGFDl>; Sat, 7 Dec 2002 00:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbSLGFDl>; Sat, 7 Dec 2002 00:03:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267619AbSLGFDl>;
	Sat, 7 Dec 2002 00:03:41 -0500
Date: Fri, 6 Dec 2002 21:07:36 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: "'Linux Kernel Development List'" <linux-kernel@vger.kernel.org>
Subject: Re: POSSIBLE BUG: Debugging Not Automatically Activated in Slab.c
In-Reply-To: <000a01c29da4$8235b370$8c43d03f@joe>
Message-ID: <Pine.LNX.4.33L2.0212062105520.27850-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Joseph D. Wagner wrote:

| Before I submit this as an actually bug, I'd like the input of some people
| who know a little more about the Slab Allocator and Kernel Debugging.
|
| The Slab Allocator includes this line:
|
| #ifdef CONFIG_DEBUG_SLAB
|
| in slab.c (line 89) to activate debugging.
|
| However, I couldn't find anywhere in the code where CONFIG_DEBUG_SLAB is
| linked to CONFIG_DEBUG_KERNEL.  In other words, setting the kernel as a
| debug kernel doesn't automatically set the Slab Allocator to debug too.

CONFIG_DEBUG_SLAB is a separate option, listed under the
Kernel Hacking config menu (Debug memory allocations).

| 1) Am I missing something?
|
| 2) Is this intentional or by design?

Design.

| If this is an actually bug, it can be fixed by inserting the following code
| in slab.h immediately following the #include statements:
|
| #ifdef CONFIG_DEBUG_KERNEL
| #define CONFIG_DEBUG_SLAB
| #endif

Nope, just enable it.

-- 
~Randy

