Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262940AbTCKPGf>; Tue, 11 Mar 2003 10:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262941AbTCKPGf>; Tue, 11 Mar 2003 10:06:35 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11494 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262940AbTCKPGe>; Tue, 11 Mar 2003 10:06:34 -0500
Date: Tue, 11 Mar 2003 16:14:08 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] include cfi_cmdset_0020 in drivers/mtd/chips/Makefile
Message-ID: <20030311151408.GA495@wohnheim.fh-wedel.de>
References: <20030227233627.GW7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030227233627.GW7685@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 February 2003 00:36:27 +0100, Adrian Bunk wrote:
> 
> 2.4.21-pre5 includes drivers/mtd/chips/cfi_cmdset_0020.c but doesn't 
> compile it. The following patch fixes it:
> 
> --- linux-2.4.21-pre5-full/drivers/mtd/chips/Makefile.old	2003-02-28 00:28:56.000000000 +0100
> +++ linux-2.4.21-pre5-full/drivers/mtd/chips/Makefile	2003-02-28 00:32:43.000000000 +0100
> @@ -17,6 +17,7 @@
>  obj-$(CONFIG_MTD)		+= chipreg.o
>  obj-$(CONFIG_MTD_AMDSTD)	+= amd_flash.o 
>  obj-$(CONFIG_MTD_CFI)		+= cfi_probe.o
> +obj-$(CONFIG_MTD_CFI_STAA)	+= cfi_cmdset_0020.o
>  obj-$(CONFIG_MTD_CFI_AMDSTD)	+= cfi_cmdset_0002.o
>  obj-$(CONFIG_MTD_CFI_INTELEXT)	+= cfi_cmdset_0001.o
>  obj-$(CONFIG_MTD_GEN_PROBE)	+= gen_probe.o

This is fixed in mtd cvs already.

Just out of curiosity: How did you notice it? Do you actually use that
driver?

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
