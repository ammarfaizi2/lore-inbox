Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUAURBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUAURBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:01:37 -0500
Received: from denise.shiny.it ([194.20.232.1]:60841 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S265973AbUAURBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:01:34 -0500
Date: Wed, 21 Jan 2004 18:01:01 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Bart Samwel <bart@samwel.tk>
cc: root@chaos.analogic.com, Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <400C4B17.3000003@samwel.tk>
Message-ID: <Pine.LNX.4.58.0401211748130.1567@denise.shiny.it>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk>
 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>
 <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>
 <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, Bart Samwel wrote:

> But we're not talking about the base kernel here. We're not talking
> about migrating the kernel to C++, or even modules that are part of the
> Linux kernel source. We're talking about *independent modules*. The
> kernel exports a module interface, and any binary driver that correctly
> hooks into the interface of the running kernel (using the correct
> calling conventions of the running kernel) and behaves properly (e.g.,
> doesn't do stack unwinds over chunks of kernel functions etc.) can hook
> into it and do useful work. If somebody has decided that it would be
> worth it for his project to use C++ (without exceptions, rtti and the
> whole shebang) then so be it, why should you care? It's just binary code
> that hooks into the module interface, using the correct calling
> conventions. It doesn't do dirty stuff -- no exceptions, no RTTI,
> etcetera. It compiles into plain, module-interface conforming assembler,
> that can be compiled with -- you guessed it -- 'as', the AT&T syntax
> assembler. Yes, they're taking a risk. Their risk is that C++ can't
> import the kernel headers, or that C++ might someday need runtime
> support that cannot be ported into the kernel.

I managed to use a a lot of C++ code in a kernel modules. I used wrapper
functions to pass data between C and C++ parts. C++ code had no exceptions
and such thing, but I had to play some dirty tricks anyway because C++
code needs stuff which is provided by userpace libraries to run.
Maybe the right solution is writing a module that provides a fast data
path between the kernel and the userspace router.


--
Giuliano.
