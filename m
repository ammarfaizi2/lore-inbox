Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGBJe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGBJe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 05:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGBJe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 05:34:56 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15853
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261847AbVGBJey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 05:34:54 -0400
Subject: Re: 2.6.13-rc1-mm1: git-mtd.patch breaks i386 compile
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Nicolas Pitre <nico@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050702091600.GF3592@stusta.de>
References: <20050701044018.281b1ebd.akpm@osdl.org>
	 <20050702091600.GF3592@stusta.de>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 02 Jul 2005 11:37:23 +0200
Message-Id: <1120297044.9241.4.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 11:16 +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   CC      drivers/mtd/chips/cfi_cmdset_0002.o
> In file included from drivers/mtd/chips/cfi_cmdset_0002.c:41:
> include/linux/mtd/xip.h:78:2: warning: #warning "missing IRQ and timer primitives for XIP MTD support"
> include/linux/mtd/xip.h:79:2: warning: #warning "some of the XIP MTD support code will be disabled"
> include/linux/mtd/xip.h:80:2: warning: #warning "your system will therefore be unresponsive when writing or erasing flash"
> drivers/mtd/chips/cfi_cmdset_0002.c:584:26: asm/hardware.h: No such file or directory
> ...
> make[3]: *** [drivers/mtd/chips/cfi_cmdset_0002.o] Error 1

Hmm, why is XIP support enabled ?

Nico, shouldn't MTD_XIP depend on XIP_KERNEL ?

tglx


