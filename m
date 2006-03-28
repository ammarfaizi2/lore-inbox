Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWC1Wtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWC1Wtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWC1Wtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:49:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50923 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932490AbWC1Wtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:49:41 -0500
Date: Wed, 29 Mar 2006 00:49:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marko <letterdrop@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who wants to test cracklinux??
Message-ID: <20060328224929.GC5760@elf.ucw.cz>
References: <20060328221223.80753cab.letterdrop@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328221223.80753cab.letterdrop@gmx.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've written a small kernel module & shared object for kernel 2.6 to
> enable the following for normal users:
> 
> - inb()/outb()... via a wrapper function

ioperm() does that already, no? You mean, you enable it for non-root,
too? That's security hole.

> - enable direct IO access (like ioperm())
> - direct access on physical memory addresses

read/write on /dev/mem. chmod 666 /dev/mem if you want to allow normal
users to access physical memory (security hole, again).

> - installation of user space ISR

That seems nice. Does it work with PCI shared interrupts?

> - change nice level
> 
> The module is primary thought for education, but perhaps also helpful
> in software development.
> The module is finished now, but because it's my first kernel code
> there could be something to improve. If anyone wants to test, just
> send me a mail and you'll get the code.

Please post it to the list.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
