Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDYTiK>; Wed, 25 Apr 2001 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRDYTiA>; Wed, 25 Apr 2001 15:38:00 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:52469 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131480AbRDYThq>;
	Wed, 25 Apr 2001 15:37:46 -0400
From: thunder7@xs4all.nl
Date: Wed, 25 Apr 2001 21:27:38 +0200
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: pcnet32.c: PCI posting bug prevents 2.4.3-ac14 compilation
Message-ID: <20010425212738.A7594@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is new - 2.4.3-ac12 built without problems.

make[3]: Entering directory `/usr/src/linux-2.4.3-ac14/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -m
preferred-stack-boundary=2 -march=i686    -c -o pcnet32.o pcnet32.c
pcnet32.c:1385: warning: #warning "PCI posting bug"
pcnet32.c:327: pcnet32_pci_tbl causes a section type conflict
make[3]: *** [pcnet32.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.3-ac14/drivers/net'

I must confess, that the meaning of the warning isn't clear to me, but
that's a warning. The session-type conflict is even more vague. Reading
the patch I don't see any obvious hints.

I'm using

Reading specs from /usr/local/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)

on a SuSE 7.1 base system.

Thanks!

Jurriaan
-- 
If something was not wrong things would not be right.
        Sergeant Ortega - Zorro
GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.13 0.03 0.01
