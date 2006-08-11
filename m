Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWHKW6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWHKW6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHKW6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:58:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751218AbWHKW6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:58:44 -0400
Date: Fri, 11 Aug 2006 15:58:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Message-Id: <20060811155841.5eedb703.akpm@osdl.org>
In-Reply-To: <1155328263.17493.20.camel@markh3.pdx.osdl.net>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<1155319901.17493.9.camel@markh3.pdx.osdl.net>
	<20060811113602.04867f46.akpm@osdl.org>
	<1155328263.17493.20.camel@markh3.pdx.osdl.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 13:31:03 -0700
Mark Haverkamp <markh@osdl.org> wrote:

> > NR_IRQS is (sometimes) calculated from NR_CPUS via complex means.  Reducing
> > your NR_CPUS should fix things up.
> 
> It helps.  I set NR_CPUS to 8 and got past that problem.  Now I can't
> get the root to mount.
> 
> Here is some output.  I had to copy it from the VGA since this doesn't
> show up on the serial output.
> 
> Creating root device
> Mounting root filesystem
> mount: error 6 mounting ext3
> Switching to new root
> ERROR opening /dev/console!!!!:2
> error dup2'ing fd of 0 to 0
> error dup2'ing fd of 0 to 1
> error dup2'ing fd of 0 to 2
> umounting old /proc
> unmounting old /sys
> Switchroot: mount failed: 22
> Kernel Panic ....

Looks like early userspace got ENXIO when trying to mount the root fs.

Don't know, sorry.  What distro is this running?

It might be useful to diff this kernel's boot log with 2.6.18-rc4's, see if
we can spot the problem that way.

