Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTFKJga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTFKJg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:36:29 -0400
Received: from ns2.q-leap.de ([153.94.51.194]:171 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S264277AbTFKJgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:36:25 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.64334.623864.358666@q-leap.com>
Date: Wed, 11 Jun 2003 11:50:06 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc7 compile error with exec-shield patch
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
X-Face: "HSWKA_'Lr\(@D}NQgU@jZukje>!f;VO]4Tj%~+[PY$M"=CmMyN.x6&X`p_X|q9.||#uM0mH%/3kBIxN-@(lB?3\_)J+ms63HsTY0{WmL3_K+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried to compile your exec-shield patch applied to
linux-2.4.21-rc7 but it gives me an error.  I applied 
http://people.redhat.com/mingo/exec-shield/exec-shield-2.4.21-rc1-B6
These are the last make lines:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-rc7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i586   -nostdinc -iwithprefix include -DKBUILD_BASENAME=traps
-c -o traps.o traps.c
traps.c: In function `trap_init_f00f_bug':
traps.c:849: `idt' undeclared (first use in this function)
traps.c:849: (Each undeclared identifier is reported only once
traps.c:849: for each function it appears in.)
make[2]: *** [traps.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.4.21-rc7/arch/i386/kernel'
make[1]: *** [_dir_arch/i386/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc7'
make: *** [stamp-build] Error 2

I also sent this to Ingo but as I don't know if it is a problem with
the patch or with kernel or a combination of both I send it to you,
too.

Thanks,

	Peter

