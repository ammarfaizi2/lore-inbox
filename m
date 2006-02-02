Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWBBBHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWBBBHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWBBBHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:07:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45327 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030237AbWBBBHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:07:38 -0500
Date: Thu, 2 Feb 2006 02:07:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Nikolay N. Ivanov" <nn@nndl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: kernel bug at net/core/net-sysfs.c:434 - kernel 2.6.16rc1
Message-ID: <20060202010733.GT3986@stusta.de>
References: <43DB2550.4070800@nndl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DB2550.4070800@nndl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 11:03:28AM +0300, Nikolay N. Ivanov wrote:

> Hello!

Hi Nikolay!

> CC      net/core/net-sysfs.o
> net/core/net-sysfs.c: In function `netdev_register_sysfs':
> net/core/net-sysfs.c:434: error: `i' undeclared (first use in this function)
>...
> [nn@ linux-2.6.16-rc1]$ gcc --version
> gcc (GCC) 3.3.4
> ---
> 
> After adding:
> 
> int i;
> 
> new errors appeared:
> 
> ---
> CC      net/core/net-sysfs.o
> net/core/net-sysfs.c: In function `netdev_register_sysfs':
> net/core/net-sysfs.c:434: error: `attr' undeclared (first use in this 
> function)
>...

Your errors don't fit in any way with what I see in line 434 of this 
file.

The following should work:
- unpack an unmodified 2.6.15 kernel source from ftp.kernel.org
- apply the 2.6.16-rc1 patch from ftp.kernel.org

> Nikolay N. Ivanov

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

