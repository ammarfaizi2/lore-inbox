Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVD0QU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVD0QU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVD0QU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:20:59 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:46728 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261794AbVD0QUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:20:43 -0400
Date: Wed, 27 Apr 2005 10:23:01 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Filip Zyzniewski <lkml@filip.math.uni.lodz.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Panic on a BIOSless machine.
In-Reply-To: <426FB641.2070802@filip.math.uni.lodz.pl>
Message-ID: <Pine.LNX.4.61.0504271022460.26410@montezuma.fsmlabs.com>
References: <426FB641.2070802@filip.math.uni.lodz.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Filip Zyzniewski wrote:

> Hi, I managed to boot kernel on a biosless box (Compaq T1000 Windows
> based terminal). It has 32MB of ram.
> 
> 
> But it panics (sometimes it even launches bash and allows me to run some
> stuff).
> 
> kernel log gathered from serial console:
> http://filip.math.uni.lodz.pl/t1000-panic/panic.log
> 
> asm code used to boot kernel:
> http://filip.math.uni.lodz.pl/t1000-panic/boot.S
> 
> tool bundling boot and kernel together:
> http://filip.math.uni.lodz.pl/t1000-panic/mk.c
> 
> kernel config:
> http://filip.math.uni.lodz.pl/t1000-panic/kernel-config
> 
> I had to comment out: jnz 2f # New command line protocol
> from arch/i386/kernel/head.S (2.6.11.7) (bootloader too old?).
> 
> Is there anything I could do to prevent it? I don't know memory map of
> this computer, is this the cause? I can't see video RAM on board, so
> maybe it is shared with system RAM? What do you think?

Try booting a kernel without the tulip driver

