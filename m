Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUHZTox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUHZTox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUHZToZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:44:25 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:48193 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269463AbUHZTjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:39:15 -0400
Date: Thu, 26 Aug 2004 21:40:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <20040826194011.GG9539@mars.ravnborg.org>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040826014745.225d7a2c.akpm@osdl.org> <200408261506.19172.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408261506.19172.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:06:18PM +0300, Denis Vlasenko wrote:
> On Thursday 26 August 2004 11:47, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
> 
> I use separate build directory.
> 
> ....
>   LD      .tmp_vmlinux1
>   KSYM    .tmp_kallsyms1.S
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   LD      .tmp_vmlinux3
>   KSYM    .tmp_kallsyms3.S
>   AS      .tmp_kallsyms3.o
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   AS      arch/i386/boot/bootsect.o
>   LD      arch/i386/boot/bootsect
>   AS      arch/i386/boot/setup.o
>   LD      arch/i386/boot/setup
>   AS      arch/i386/boot/compressed/head.o
>   CC      arch/i386/boot/compressed/misc.o
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>   GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
>   LD      arch/i386/boot/compressed/piggy.o
>   LD      arch/i386/boot/compressed/vmlinux
>   OBJCOPY arch/i386/boot/vmlinux.bin
>   HOSTCC  arch/i386/boot/tools/build
> cc1: No such file or directory: opening dependency file arch/i386/boot/tools/.build.d
> make[2]: *** [arch/i386/boot/tools/build] Error 1
> make[1]: *** [bzImage] Error 2
> make: *** [bzImage] Error 2
> 
> build dir does not have arch/i386/boot/tools/build/tools/ at all.
> src dir has lone build.c in arch/i386/boot/tools/build/tools/.

Correct.
Fixet - see mail with subject "kbuild fixes" sent to lkml.

	Sam
