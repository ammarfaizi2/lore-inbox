Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSHLBgh>; Sun, 11 Aug 2002 21:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318552AbSHLBgh>; Sun, 11 Aug 2002 21:36:37 -0400
Received: from quechua.inka.de ([212.227.14.2]:3450 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S318546AbSHLBgg>;
	Sun, 11 Aug 2002 21:36:36 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <Pine.LNX.4.44.0208112109110.16360-100000@skynet>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17e4C2-0005yH-00@sites.inka.de>
Date: Mon, 12 Aug 2002 03:40:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208112109110.16360-100000@skynet> you wrote:
> It works by using kernel modules to get a definite view of what the kernel
> is at and to provide reliable, reproducible tests. Modules are divided
> up into 4 catagories. Core modules provide infrastructure for the tool.
> Sense modules tell what is going on in the VM. Test tests particular
> features and bench modules (none yet) will benchmark different sections
> of the VM.

This sounds more like a micro benchmark tool, which is a good start, but the
real problem with VM optimizations is, that they have to take into account
real world load and especially user experience.

A simple example is the fact, that an idle desktop box will feel very sluggy
if a user comes back after a few hours break, because all visible programs
are paged out. To improve this, one could think about adding a flag to
applications like "connected to gui". This feature would need a test then,
which is no usual micro benchmark.

So I think it is a good idea to avoid to introduce slow operations in
hot code path, but it does not help much the developers in the problem of
simulating workload and measuring the interactive and real throughput.

But perhaps you can take this into account?

Greetings
Bernd
