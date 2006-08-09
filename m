Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbWHIHJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbWHIHJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWHIHJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:09:33 -0400
Received: from ns.suse.de ([195.135.220.2]:4311 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030570AbWHIHJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:09:32 -0400
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.18-rc4 warning on arch/x86_64/boot/compressed/head.o
Date: Wed, 9 Aug 2006 09:09:19 +0200
User-Agent: KMail/1.9.3
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <7161.1155005268@kao2.melbourne.sgi.com> <200608080455.34702.ak@suse.de> <Pine.LNX.4.61.0608090823570.11585@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608090823570.11585@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090909.19985.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 08:26, Jan Engelhardt wrote:
> >> Compiling 2.6.18-rc4 on x86_64 gets this warning.
> >> 
> >>   gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2 -I$KBUILD_OUTPUT/linux/include -include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32  -c -o arch/x86_64/boot/compressed/head.o $KBUILD_OUTPUT/linux/arch/x86_64/boot/compressed/head.S
> >>   ld -m elf_i386  -Ttext 0x100000 -e startup_32 -m elf_i386 arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/misc.o arch/x86_64/boot/compressed/piggy.o -o arch/x86_64/boot/compressed/vmlinux 
> >> ld: warning: i386:x86-64 architecture of input file `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
> >
> >It always gave that since some binutils update long ago.
> >If you know how to fix it please submit a patch, but as far as I know it's harmless.
> 
> Why is -m elf_i386 passed to ld?
> I suppose because this is necessary because AMD64 starts in i386 16-bit 
> real mode?
> Might try -m elf32-little or -m elf64-little.

If you think you have a solution please submit a tested patch.

-Andi
