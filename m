Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTHWOOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTHWOOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 10:14:35 -0400
Received: from AMarseille-201-1-3-186.w193-253.abo.wanadoo.fr ([193.253.250.186]:24615
	"EHLO gaston") by vger.kernel.org with ESMTP id S263537AbTHWOOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:14:31 -0400
Subject: Re: [PATCH] 2.6.0-test4 PowerMac IDE breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxppc-devel@lists.linuxppc.org
In-Reply-To: <200308231221.h7NCLp0m017908@harpo.it.uu.se>
References: <200308231221.h7NCLp0m017908@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061648059.805.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 16:14:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 14:21, Mikael Pettersson wrote:
> PowerMac's IDE driver got broken in 2.6.0-test4:
> 
>   ppc-unknown-linux-gcc -Wp,-MD,drivers/ide/ppc/.pmac.o.d -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -D__KERNEL__ -Iinclude -Iarch/ppc -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include  -Idrivers/ide  -DKBUILD_BASENAME=pmac -DKBUILD_MODNAME=pmac -c -o drivers/ide/ppc/pmac.o drivers/ide/ppc/pmac.c
> drivers/ide/ppc/pmac.c: In function `pmac_ide_build_sglist':
> drivers/ide/ppc/pmac.c:945: warning: passing arg 1 of `blk_rq_map_sg' from incompatible pointer type
> 
> Fixed by the patch below.

Patch for this (and others) inluding other updates to the driver
on it's way to Linus... 

Ben.

