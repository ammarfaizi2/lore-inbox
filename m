Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbSJVO3i>; Tue, 22 Oct 2002 10:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbSJVO3i>; Tue, 22 Oct 2002 10:29:38 -0400
Received: from 3E6B24DD.aarh.stofanet.dk ([62.107.36.221]:9891 "EHLO
	snorke.stavtrup-st.dk") by vger.kernel.org with ESMTP
	id <S262681AbSJVO3g> convert rfc822-to-8bit; Tue, 22 Oct 2002 10:29:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: David Nielsen <Lovechild@foolclan.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-mm(1|2) compile error
Date: Tue, 22 Oct 2002 16:35:43 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210221635.43309.Lovechild@foolclan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a little error that's been bothering me in the lastest two -mm kernels.

gcc -Wp,-MD,kernel/.softirq.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=athlon  -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=softirq   -c -o kernel/softirq.o kernel/softirq.c
kernel/softirq.c:353: cpu_nfb causes a section type conflict
make[2]: *** [kernel/softirq.o] Error 1
make[1]: *** [kernel] Error 2
make: *** [vmlinux] Error 2

Regards
David Nielsen

please CC me, I'm not on lkml.
