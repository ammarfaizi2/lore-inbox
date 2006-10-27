Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWJ0Wma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWJ0Wma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWJ0Wma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:42:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWJ0Wm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:42:29 -0400
Date: Fri, 27 Oct 2006 15:38:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-Id: <20061027153854.b44c4ecb.akpm@osdl.org>
In-Reply-To: <20061027222326.GC27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061026224541.GQ27968@stusta.de>
	<20061027010252.GV27968@stusta.de>
	<20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027222326.GC27968@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 00:23:26 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> ...
> > So no, this should not be marked BROKEN.
> > 
> > It's a very experimental feature, as the help text says.  If you can
> > think of any harsher language to put in that text, please let me know.
> 
> The problem is that if only 1 out of 100 people who are compiling a 
> kernel accidentally enable this option, linux-kernel will be swamped 
> with bug reports...
> 

Yes, that's a legitimate practical concern, IMO.

I guess many of the people who test -rc kernels have sufficient familarity
to know to disable this option, but a lot of the people who test major
releases do not.  So how about we mark PCI_MULTITHREAD_PROBE as broken in
2.6.19-rc6, then revert that change in 2.6.20-rc1, and keep doing that
until the feature is ready?


