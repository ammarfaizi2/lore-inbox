Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFCSRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFCSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:17:51 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:56765 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S262008AbTFCSRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:17:49 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Tue, 03 Jun 2003 11:30:59 -0700
In-Reply-To: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva> (message
 from Marcelo Tosatti on Tue, 3 Jun 2003 14:04:44 -0300 (BRT))
Message-ID: <877k83xbbw.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Now I really hope its the last one, all this rc's are making me mad.

i still can't get it to compile for sparc32:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
/usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_nocheck':
/usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `d' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `l' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_from_user':
/usr/src/linux/include/asm/checksum.h:81: error: asm-specifier for variable `d' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h:81: error: asm-specifier for variable `l' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h:81: error: asm-specifier for variable `s' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_to_user':
/usr/src/linux/include/asm/checksum.h:108: error: asm-specifier for variable `d' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h:108: error: asm-specifier for variable `l' conflicts with asm clobber list
/usr/src/linux/include/asm/checksum.h:108: error: asm-specifier for variable `s' conflicts with asm clobber list
make[3]: *** [ksyms.o] Error 1
make[3]: Leaving directory `/usr/src/linux/kernel'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [_dir_kernel] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2

not sure when this started. the last kernel i managed to compile was
rc2 (skipped rc3 and rc4, rc5 didn't compile). the last one that will
boot was 2.4.21-pre1. this is on a sun4m Fujitsu TurboSparc.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
