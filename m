Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEERc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTEERc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:32:57 -0400
Received: from k1.dinoex.de ([80.237.200.94]:8719 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S261188AbTEERc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:32:56 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.69, TR] compile error
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 05 May 2003 19:27:00 +0200
Message-ID: <87bryh9ue3.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This seems to be a fallout from the irq-type changes:

  gcc -Wp,-MD,drivers/net/pcmcia/.ibmtr_cs.o.d -D__KERNEL__ -Iinclude
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium2
  -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
  -DMODULE   -DKBUILD_BASENAME=ibmtr_cs -DKBUILD_MODNAME=ibmtr_cs -c
  -o drivers/net/pcmcia/ibmtr_cs.o drivers/net/pcmcia/ibmtr_cs.c
In file included from drivers/net/pcmcia/ibmtr_cs.c:71:
drivers/net/tokenring/ibmtr.c: In function `tok_open':
drivers/net/tokenring/ibmtr.c:903: warning: `MOD_INC_USE_COUNT' is
  deprecated (declared at include/linux/module.h:456)
In file included from drivers/net/pcmcia/ibmtr_cs.c:71:
drivers/net/tokenring/ibmtr.c: In function `tok_close':
drivers/net/tokenring/ibmtr.c:1068: warning: `MOD_DEC_USE_COUNT' is
  deprecated (declared at include/linux/module.h:468)
drivers/net/pcmcia/ibmtr_cs.c: At top level:
drivers/net/pcmcia/ibmtr_cs.c:130: conflicting types for
  `tok_interrupt'
drivers/net/tokenring/ibmtr.c:1170: previous declaration of
  `tok_interrupt'
make[3]: *** [drivers/net/pcmcia/ibmtr_cs.o] Fehler 1
make[2]: *** [drivers/net/pcmcia] Fehler 2
make[1]: *** [drivers/net] Fehler 2
make: *** [drivers] Fehler 2

-- 
#include <~/.signature>: permission denied
