Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751226AbVJKN4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVJKN4t (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 11 Oct 2005 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVJKN4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:56:49 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24244 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751226AbVJKN4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:56:48 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: etienne.lorrain@masroudeau.com
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Date: Tue, 11 Oct 2005 16:56:30 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
In-Reply-To: <2031.192.168.201.6.1128591983.squirrel@pc300>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510111656.30403.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 12:46, Etienne Lorrain wrote:
>   Hello,
> 
>  This is following that set of patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112557274910448&w=4
>  to get a simpler structure of the vmlinux boot file, named like:
> /boot/linux-2.6.14.kgz
> 
>  This linux-*.kgz format is the "native" format of the Gujin
> bootloader which can be found here:
> http://gujin.org

/me looking at the site
Wow. Isn't this overdesigned by wide margin?

>  The main change of this set of patch is the rewrite of nearly all
> the ia16/ia32 assembler of Linux into a C file named "realmode.c",
> and its include "realmode.h". The mapping of the 4 Kbytes memory
> page exchanged in between real mode and protected mode is exactly
> the same, but is described in a C structure - a lot cleaner.
>  Another big change is that the GZIP compressed file produced during
> Linux compilation now contains a comment describing some important
> information: which processor this kernel has been compiled for (so
> no invalid instruction crash when running a Athlon compiled kernel
> on a Pentium - but a nice error message from the bootloader), which
> video mode the kernel support (VGA text or VESA, and which VESA)...
>
>  If you apply this set of patch, you still can use the old method
> to boot a kernel with LILO, Loadlin, Grub or SYSLINUX, and this
> patch will not modify any assembler instruction executed on this
> boot path when you use "make bzImage" or the like.
>  To produce the new format you just have to apply at least the
> first two patch and type "make /boot/linux-gujin.kgz ROOT=auto",
> or apply the 3rd patch to get root autodetection (based on the
> partition/directory of the linux*.kgz file loaded) and type
> "make /boot/linux-gujin.kgz". (also see "make help")

Apart from shaving a few kb's from kernel image (which are discarded
anyway after boot, IIRC), what advantages does this bring?
Do they outweigh effort needed to maintain it?
--
vda
