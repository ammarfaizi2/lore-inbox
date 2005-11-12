Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVKLWJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVKLWJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVKLWJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:09:29 -0500
Received: from lixom.net ([66.141.50.11]:43988 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S964840AbVKLWJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:09:29 -0500
Date: Sat, 12 Nov 2005 14:08:53 -0800
To: Michael Buesch <mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051112220853.GB10506@pb15.lixom.net>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 10:37:16PM +0100, Michael Buesch wrote:

> The result of the build is:
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o: In function `platform_init':
> : undefined reference to `prep_init'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `ucSystemType'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_prep_type'
> make: *** [.tmp_vmlinux1] Error 1

Disabling CONFIG_PPC_PREP and CONFIG_PPC_CHRP will work around it for
now, neither are needed for a powermac.


-Olof
