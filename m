Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUBCQqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBCQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:46:14 -0500
Received: from s4.uklinux.net ([80.84.72.14]:18098 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S266004AbUBCQqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:46:11 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>
	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>
	<87d68xcoqi.fsf@codematters.co.uk> <401EDEF2.6090802@cyberone.com.au>
	<20040202154959.283cf60b.akpm@osdl.org>
	<87isipvuvz.fsf@codematters.co.uk> <401F0F5F.10306@cyberone.com.au>
From: Philip Martin <philip@codematters.co.uk>
Date: Tue, 03 Feb 2004 16:44:57 +0000
In-Reply-To: <401F0F5F.10306@cyberone.com.au> (Nick Piggin's message of
 "Tue, 03 Feb 2004 14:02:55 +1100")
Message-ID: <87ptcw2jue.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

> OK now thats strange - you're definitely compiling the same kernel
> with the same .config and compiler?

It's definitely the same compiler (Debian's 2.95.4).  I think the 2.4
and 2.6 configs have to be different, but they are similar, these are
the differences

 < in 2.4
 > in 2.6

 < CONFIG_AUTOFS4_FS=y
 > CONFIG_BLK_DEV_CRYPTOLOOP=m
 > CONFIG_BLK_DEV_IDECD=m
 < CONFIG_BLK_DEV_IDE_MODES=y
 > CONFIG_CLEAN_COMPILE=y
 > CONFIG_CRC32=m
 > CONFIG_CRYPTO=y
 > CONFIG_DUMMY_CONSOLE=y
 > CONFIG_EPOLL=y
 > CONFIG_EXPORTFS=m
 > CONFIG_FB=y
 > CONFIG_FB_ATY=m
 > CONFIG_FB_ATY_CT=y
 < CONFIG_FILTER=y
 > CONFIG_FUTEX=y
 > CONFIG_GENERIC_ISA_DMA=y
 < CONFIG_HFSPLUS_FS=m
 > CONFIG_HW_CONSOLE=y
 > CONFIG_INPUT=y
 > CONFIG_INPUT_KEYBOARD=y
 > CONFIG_INPUT_MOUSE=y
 > CONFIG_INPUT_MOUSEDEV=y
 > CONFIG_INPUT_MOUSEDEV_PSAUX=y
 > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 > CONFIG_IOSCHED_AS=y
 > CONFIG_IOSCHED_DEADLINE=y
 > CONFIG_IOSCHED_NOOP=y
 > CONFIG_KALLSYMS=y
 < CONFIG_KCORE_ELF=y
 > CONFIG_KEYBOARD_ATKBD=y
 < CONFIG_LOG_BUF_SHIFT=0
 > CONFIG_LOG_BUF_SHIFT=15
 > CONFIG_MII=m
 > CONFIG_MMU=y
 > CONFIG_MOUSE_SERIAL=y
 > CONFIG_OBSOLETE_MODPARM=y
 > CONFIG_PC=y
 > CONFIG_PREEMPT=y
 > CONFIG_PROC_KCORE=y
 > CONFIG_SCSI_PROC_FS=y
 < CONFIG_SD_EXTRA_DEVS=40
 < CONFIG_SERIAL=y
 > CONFIG_SERIAL_8250=y
 > CONFIG_SERIAL_8250_NR_UARTS=4
 > CONFIG_SERIAL_CORE=y
 > CONFIG_SERIO=y
 > CONFIG_SERIO_I8042=y
 > CONFIG_SERIO_SERPORT=y
 > CONFIG_SOUND_GAMEPORT=y
 < CONFIG_SR_EXTRA_DEVS=2
 > CONFIG_STANDALONE=y
 > CONFIG_SWAP=y
 > CONFIG_X86_BIOS_REBOOT=y
 > CONFIG_X86_EXTRA_IRQS=y
 < CONFIG_X86_F00F_WORKS_OK=y
 > CONFIG_X86_FIND_SMP_CONFIG=y
 < CONFIG_X86_HAS_TSC=y
 > CONFIG_X86_HT=y
 > CONFIG_X86_INTEL_USERCOPY=y
 > CONFIG_X86_MPPARSE=y
 > CONFIG_X86_PC=y
 < CONFIG_X86_PGE=y
 > CONFIG_X86_SMP=y
 > CONFIG_X86_TRAMPOLINE=y



-- 
Philip Martin
