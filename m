Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUATGqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUATGqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:46:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:65258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265171AbUATGqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:46:30 -0500
Date: Mon, 19 Jan 2004 22:46:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <200401200159.22693.robin.rosenberg.lists@dewire.com>
Message-ID: <Pine.LNX.4.58.0401192241080.2311@home.osdl.org>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <400C37E3.5020802@samwel.tk> <Pine.LNX.4.53.0401191521400.8389@chaos>
 <200401200159.22693.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jan 2004, Robin Rosenberg wrote:
> 
> This is the "We've always used COBOL^H^H^H^H" argument. 

In fact, in Linux we did try C++ once already, back in 1992.

It sucks. Trust me - writing kernel code in C++ is a BLOODY STUPID IDEA.

The fact is, C++ compilers are not trustworthy. They were even worse in 
1992, but some fundamental facts haven't changed:

 - the whole C++ exception handling thing is fundamentally broken. It's 
   _especially_ broken for kernels.
 - any compiler or language that likes to hide things like memory
   allocations behind your back just isn't a good choice for a kernel.
 - you can write object-oriented code (useful for filesystems etc) in C, 
   _without_ the crap that is C++.

In general, I'd say that anybody who designs his kernel modules for C++ is 
either 
 (a) looking for problems
 (b) a C++ bigot that can't see what he is writing is really just C anyway
 (c) was given an assignment in CS class to do so.

Feel free to make up (d).

		Linus
