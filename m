Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTFDScB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTFDScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:32:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:656 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261787AbTFDSb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:31:59 -0400
Date: Wed, 4 Jun 2003 14:48:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sys_sysfs used? 
In-Reply-To: <Pine.LNX.4.44.0306041124250.13077-100000@cherise>
Message-ID: <Pine.LNX.4.53.0306041442100.1500@chaos>
References: <Pine.LNX.4.44.0306041124250.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Patrick Mochel wrote:

>
> In fs/filesystems.c, we have sys_sysfs:
>
> /*
>  * Whee.. Weird sysv syscall.
>  */
> asmlinkage long sys_sysfs(int option, unsigned long arg1, unsigned long arg2)
> {
> 	...
> }
>
> Which is, as advertised, kinda weird.
>
> I see that only one architecture defines __NR_sysfs: x86-64, though it
> appears most architectures mention it in arch/*/kernel/entry.S (or
> equivalent).
>
> Is it used anymore? Would it be possible to remove it?
>
>
> 	-pat

But what would you use as a place-holder?? There are lots
of unused sys-calls (break, acct, lock, mpx, etc). You
certainly can't be running out of numbers, and you certainly
can't remove  a number and change everything else, you'll
not get up, even with static-linked files!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

