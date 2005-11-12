Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVKLWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVKLWUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:20:42 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:41738 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932353AbVKLWUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:20:42 -0500
Date: Sat, 12 Nov 2005 23:22:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexander Kozyrev <kozyrev@junik.lv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel compilation
Message-ID: <20051112222213.GB10228@mars.ravnborg.org>
References: <200511121813.jACIDpXa055161@mail.junik.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121813.jACIDpXa055161@mail.junik.lv>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 08:13:40PM +0200, Alexander Kozyrev wrote:
> Linux asterisk1.local 2.6.9-11.EL #1 Wed Jun 8 16:59:52 CDT 2005 i686 i686
> i386 GNU/Linux
> After 2 hours of compilation -
> <......>
>   CC      lib/string.o
>   CC      lib/vsprintf.o
>   AR      lib/lib.a
>   CC [M]  lib/crc-ccitt.o
>   CC [M]  lib/libcrc32c.o
>   LD      arch/i386/lib/built-in.o
>   CC      arch/i386/lib/bitops.o
>   AS      arch/i386/lib/checksum.o
>   CC      arch/i386/lib/delay.o
>   AS      arch/i386/lib/getuser.o
>   CC      arch/i386/lib/memcpy.o
>   CC      arch/i386/lib/strstr.o
>   CC      arch/i386/lib/usercopy.o
>   AR      arch/i386/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> ld: kernel/built-in.o: No such file: No such file or directory
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [_all] Error 2
> 
> 4 times with the same error.
You experienced a compile error in kernel/
Try 
make kernel/

to see what is causing your trouble.

When something fails to build in kernel/ then built-in.o is not
made. And then the later build stages will fail.

I assume you are using make -J 2 (or higher)

PS. You do not need to do a make clean/ make mrproper - the result is
the same.

	Sam
