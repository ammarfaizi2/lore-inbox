Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbSBLNCG>; Tue, 12 Feb 2002 08:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291021AbSBLNBu>; Tue, 12 Feb 2002 08:01:50 -0500
Received: from krynn.axis.se ([193.13.178.10]:1682 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S285935AbSBLNBj>;
	Tue, 12 Feb 2002 08:01:39 -0500
Date: Tue, 12 Feb 2002 14:01:13 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.165730.59656439.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1020212135811.18244A-100000@fafner.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, David S. Miller wrote:
>    Where's the problem to compute them automatically?
> 
> It requires ugly scripts that parse assembler files if you want it to
> work in a cross compilation requirement.  Check out
> arch/sparc64/kernel/check_asm.sh and the "check_asm" rule in the
> Makefile or the same directory in older trees to see what I mean.

We cross-compile all the time and don't have to parse assembler-files,
just compile a c-file and include the resulting asm into entry.S:

/* linux/arch/cris/entryoffsets.c
 *
 * Copyright (C) 2001 Axis Communications AB
 *
 * Generate structure offsets for use in entry.S.  No extra processing
 * needed more than compiling this file to assembly code.  Horrendous
 * assembly code will be generated, so don't look at that.
 *
 * Authors:     Hans-Peter Nilsson (hp@axis.com)
 */

/BW

