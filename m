Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTAWVJR>; Thu, 23 Jan 2003 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbTAWVJR>; Thu, 23 Jan 2003 16:09:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30663 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267281AbTAWVJR>;
	Thu, 23 Jan 2003 16:09:17 -0500
Date: Thu, 23 Jan 2003 22:18:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123211805.GY910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <20030123181002.GV910@suse.de> <20030123185554.GC9141@ulima.unil.ch> <20030123190711.GW910@suse.de> <20030123192140.GD9141@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123192140.GD9141@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Gregoire Favre wrote:
>   	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
> drivers/built-in.o(.text+0x5c563): In function `cdrom_end_request':
> : undefined reference to `block_pc_request'
> make: *** [vmlinux] Error 1
> 
> Sorry I certainly didn't understand you right...

No it's my mistake, should be blk_pc_request(). Sorry about that.

-- 
Jens Axboe

