Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315553AbSEQKht>; Fri, 17 May 2002 06:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315559AbSEQKhs>; Fri, 17 May 2002 06:37:48 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10767 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315553AbSEQKhr>; Fri, 17 May 2002 06:37:47 -0400
Date: Fri, 17 May 2002 12:37:44 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.15: pdc202xx.c compile failure?
Message-ID: <20020517103744.GA19298@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I used linux-2.5.7 and applied all patches up to 2.5.15 with
scripts/patch-kernel.

I did make oldconfig ; make dep clean bzImage and compiling the promise
IDE driver gives this:

make[3]: Entering directory `/suse/kernel/linux-2.5.15/drivers/ide'
gcc -D__KERNEL__ -I/suse/kernel/linux-2.5.15/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4    -DKBUILD_BASENAME=pdc202xx  -c -o
pdc202xx.o pdc202xx.c
pdc202xx.c:1453: unknown field `exnablebits' specified in initializer

And a lot of warnings about missing initializers.

Here's my stripped and gzipped .config:

begin 644 config-stripped.gz
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
!````
`
end

-- 
Matthias Andree
