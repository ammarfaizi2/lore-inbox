Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262638AbSJHAn4>; Mon, 7 Oct 2002 20:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbSJHAn4>; Mon, 7 Oct 2002 20:43:56 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:23938 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262638AbSJHAnz>;
	Mon, 7 Oct 2002 20:43:55 -0400
Date: Mon, 7 Oct 2002 19:48:32 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.40 64GB highmem BUG()
In-Reply-To: <200210071327.GAA00711@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0210071946150.4381-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Adam J. Richter wrote:

> 	Although 2.5.40 has been out for a while, I think I ought
> to post this bug as I haven't seen any other mention of it.
> 
> 	When I boot an 2.5.40 x86 kernel built with CONFIG_HIGHMEM64G,
> and with a 920kB initial ramdisk (2.2MB uncompressed), I get a kernel
> BUG() at highmem.c line 480, preceded by a message saying "scheduling
> with KM_TYPE 15 held!"  The machine on which I experienced this
> problem has 1.25GB of RAM.  The problem occurs with and without
> CONFIG_PREEMPT.  All kernels that tried were SMP kernels running on a
> uniprocessor.
> 
> 	The problem does not occur if I build 2.5.40 with
> CONFIG_HIGHMEM4G or CONFIG_NOHIGMEM.  So, it's probably not causing
> problems for many people, but I thought I should report it anyhow.

Does the accompanying trace output say BUG(), or is there a might_sleep() 
in the trace output?  In other words, is it a scheduling while holding a 
lock kind of thing?


