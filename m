Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTACSrS>; Fri, 3 Jan 2003 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267626AbTACSrR>; Fri, 3 Jan 2003 13:47:17 -0500
Received: from ligur.expressz.com ([212.24.178.154]:19407 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S267625AbTACSrP>;
	Fri, 3 Jan 2003 13:47:15 -0500
Date: Fri, 3 Jan 2003 19:55:45 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: sparclinux@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.54-sparc64 compile errors
In-Reply-To: <Mutt.LNX.4.44.0301040331530.18132-100000@blackbird.intercode.com.au>
Message-ID: <Pine.LNX.3.96.1030103194702.7821A-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, James Morris wrote:

> See the patch below for a fix for this.
[...]
> You need to set CONFIG_INPUT=y to fix this at the moment (even if you 
> don't have any input devices configured).

	Thank you for the help for everyone the compile was successful.
With preempt didn't boot the machine. This is a possible couse only, I
made more changes between the two version's (booting and not booting)
config.
	After booting I can't insmod (even with insmod nor with modprobe)
anything with the following error message:

mortimer:~# modprobe nfs
WARNING: Error inserting sunrpc (/lib/modules/2.5.54/kernel/net/sunrpc/sunrpc.ko): Cannot allocate memory
WARNING: Error inserting lockd (/lib/modules/2.5.54/kernel/fs/lockd/lockd.ko): Cannot allocate memory
FATAL: Error inserting nfs (/lib/modules/2.5.54/kernel/fs/nfs/nfs.ko): Cannot allocate memory

With strace I found this, is it normal?
238   create_module(0, 0)               = -1 ENOSYS (Function not implemented)

module-init-tools version 0.9.7

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

