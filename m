Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRKMAPS>; Mon, 12 Nov 2001 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRKMAPI>; Mon, 12 Nov 2001 19:15:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:19938 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281248AbRKMAOy>;
	Mon, 12 Nov 2001 19:14:54 -0500
Date: Tue, 13 Nov 2001 01:14:40 +0100
Message-Id: <200111130014.fAD0Eel15650@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: jamagallon@able.es ("J . A . Magallon")
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011113004846.G1531@werewolf.able.es>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011113004846.G1531@werewolf.able.es> you wrote:
>
> This is an update-cleanup of the i2c code to the current CVS. In short,
> it adds version info printing and some CONFIG_ cleanups (there were
> CONFIG_ vars defined in Config.in that had been renamed inside the code).
> Please consider for next pre of 2.4.15.

Could you please think before doing a merge next time?
The patch backs out local changes like ite support:

> -obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
> -obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
> -obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
> +obj-$(CONFIG_I2C_PCFISA)	+= i2c-elektor.o
>  obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
