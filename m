Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbSJMXtl>; Sun, 13 Oct 2002 19:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSJMXtl>; Sun, 13 Oct 2002 19:49:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31607 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261781AbSJMXtk>; Sun, 13 Oct 2002 19:49:40 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: rmk@arm.linux.org.uk, ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210132310.QAA01044@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 17:54:12 -0600
In-Reply-To: <200210132310.QAA01044@adam.yggdrasil.com>
Message-ID: <m1wuollwt7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Russell King writes:
> >x86, I believe, is one example of such a platform that can leave PCI
> >devices jabbering over a warm reboot.
> 
> 	The standards on pcisig.com are apparently proprietary, so I'm
> afraid I can only quote a proprietary book I have handy:

Rebooting on x86 is returning control to the BIOS not pressing the external
reset line.

> 	So, you must be talking about a PC that does not ground RST#
> during a warm reboot or out of spec (according to this book) PCI devices,
> which would not be specific to x86 unless we're talking about motherboard
> chipset devices.

Exactly an in spec, PC does not need to ground RST# on reboot.
 
> 	I understand the benefits of being conservative, but let's not
> be taken in by urban legend, or, more likely, some quirkly hardware
> that we can set a flag for while we can reboot more quickly with most
> other hardware.  Anyhow, if you or anyone can give me specifics about
> devices jabbering away after reboot, that would be great

On 2.4.x don't down a network interface, before you reboot.
 
> 	I have no objection to replacing or supplementing the reboot
> notifier chain with a method in struct device_driver, but let's not
> overload these methods with ambiguous semantics.  I do not want to
> call thirty functions that primarily return memory to various memory
> allocators, mark a bunch of inodes as invalid, and otherwise arrange
> things so that the kernel can smoothly continue to run user level
> programs when, in fact, we just want to pull the reset line on the
> computer.

As soon as you start tracking the code and complaining about the correct
pieces I think it will start digging up a list.  Currently I do not
see that a productive piece of conversation.

Eric
