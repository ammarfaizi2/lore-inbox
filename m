Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWHHC4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWHHC4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWHHC4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:56:19 -0400
Received: from ns1.suse.de ([195.135.220.2]:7593 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751218AbWHHC4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:56:19 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.6.18-rc4 warning on arch/x86_64/boot/compressed/head.o
Date: Tue, 8 Aug 2006 04:55:34 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <7161.1155005268@kao2.melbourne.sgi.com>
In-Reply-To: <7161.1155005268@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080455.34702.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 04:47, Keith Owens wrote:
> Compiling 2.6.18-rc4 on x86_64 gets this warning.
> 
>   gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2 -I$KBUILD_OUTPUT/linux/include -include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32  -c -o arch/x86_64/boot/compressed/head.o $KBUILD_OUTPUT/linux/arch/x86_64/boot/compressed/head.S
>   ld -m elf_i386  -Ttext 0x100000 -e startup_32 -m elf_i386 arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/misc.o arch/x86_64/boot/compressed/piggy.o -o arch/x86_64/boot/compressed/vmlinux 
> ld: warning: i386:x86-64 architecture of input file `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
> 

It always gave that since some binutils update long ago.
If you know how to fix it please submit a patch, but as far as I know it's harmless.

-Andi
