Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTBKHRN>; Tue, 11 Feb 2003 02:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTBKHRM>; Tue, 11 Feb 2003 02:17:12 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:24484 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267257AbTBKHRL>; Tue, 11 Feb 2003 02:17:11 -0500
Message-Id: <200302110726.h1B7QnBo010420@eeyore.valparaiso.cl>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>, brand@eeyore.valparaiso.cl
Subject: Re: linux-2.5.59 kills ld.so.cache and some shared libraries. 
In-Reply-To: Your message of "Mon, 10 Feb 2003 15:43:48 EST."
             <Pine.LNX.3.95.1030210152059.250A-100000@chaos.analogic.com> 
Date: Tue, 11 Feb 2003 08:26:49 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:

[...]

> However, after running it for an hour, I tried to reboot. The
> root file-system was permanently busy so it didn't get un-mounted.
> 
> Upon re-boot, there was a very long fsck in which a lot of
> stuff had to be "fixed", much more than simply a bad dismount.

I've seen this with PIIX and Western Digital IDE disks with DMA on on
several 2.4 kernels: Slow(ish) corruption of filesystems, even when
read-mostly. It looks like accesing the filesystem screws it up, not only
writing (i.e., / is at highest risk, even if you almost never write there).
It is quite entertaining to have /etc turn into a plain file...

Dunno if related. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
