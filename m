Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTIONtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbTIONtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:49:18 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:29326 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261355AbTIONsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:48:18 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Chris Meadors <twrchris@hereintown.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3F65B2BD.9000206@cyberone.com.au>
References: <200309151146.h8FBkXcw001170@81-2-122-30.bradfords.org.uk>
	 <3F65B2BD.9000206@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1063633563.215.16.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Sep 2003 09:46:04 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19ytiD-0003Re-Ty*onm0/2n.i6Q*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 08:38, Nick Piggin wrote:

> OK, the reason why I don't like the sound of this is because the size
> of your option set has now been squared, and its no longer "make these
> CPUs work".

The way I see the config option working is, having a sub-menu that says
something like, "Select the CPU the kernel will be run on."  From there
you can pick one CPU.  This sets the in kernel optimizations for that
CPU, along with the work arounds (obviously).  It also sets the compiler
flags for the padding, and "-march=[CPU]".  Then in a sub-menu of this
menu, there is an "Advanced processor selection".  The help text would
be something like, "In addition to the primary processor selected above,
also allow this kernel to be booted on the processors selected below. 
Selecting this option disables some of the optimizations for the primary
processor."  Just turning on that option would change the "-march=" to
"-mcpu=".  Then in the menu one could select from any of the CPUs
listed.  Each one would enable the work around code to allow the built
kernel to run correctly on a machine with a different CPU.

I see this as sort of like the advanced partition selection, or the
compiled in fonts.

> I can see an argument for cache line size but thats about it. I can't
> think of my optimisations that should be done on one architecture but
> not another.

Don't forget the compiler optimization flags.  A kernel built with
"-march" may not run on any other CPUs.

-- 
Chris

