Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTABLli>; Thu, 2 Jan 2003 06:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTABLli>; Thu, 2 Jan 2003 06:41:38 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:11789 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S261370AbTABLlh>;
	Thu, 2 Jan 2003 06:41:37 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.54, PNP, SOUND] compile error
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Thu, 02 Jan 2003 12:39:50 +0100
Message-ID: <87hecr4w6x.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It compiled well without PNP, now with the following PNP in .config:

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_CARD=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

the error is:

  CC [M]  sound/isa/cs423x/cs4232.o
In file included from sound/isa/cs423x/cs4232.c:2:
sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_isapnp':
sound/isa/cs423x/cs4236.c:287: warning: implicit declaration of function `isapnp_find_dev'
sound/isa/cs423x/cs4236.c:287: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:288: structure has no member named `active'
sound/isa/cs423x/cs4236.c:292: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:293: structure has no member named `active'
sound/isa/cs423x/cs4236.c:298: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:299: structure has no member named `active'
sound/isa/cs423x/cs4236.c:307: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:310: warning: implicit declaration of function `isapnp_resource_change'
sound/isa/cs423x/cs4236.c:321: structure has no member named `activate'
sound/isa/cs423x/cs4236.c:339: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:340: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:345: structure has no member named `activate'
sound/isa/cs423x/cs4236.c:347: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:356: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:357: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:358: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:365: structure has no member named `activate'
sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_deactivate':
sound/isa/cs423x/cs4236.c:386: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:390: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:394: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c: In function `alsa_card_cs423x_init':
sound/isa/cs423x/cs4236.c:588: warning: implicit declaration of function `isapnp_probe_cards'
make[4]: *** [sound/isa/cs423x/cs4232.o] Fehler 1
make[3]: *** [sound/isa/cs423x] Fehler 2
make[2]: *** [sound/isa] Fehler 2
make[1]: *** [sound] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.5.54'
make: *** [stamp-build] Fehler 2

Jochen

-- 
#include <~/.signature>: permission denied
