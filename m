Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbTCEIjh>; Wed, 5 Mar 2003 03:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbTCEIjh>; Wed, 5 Mar 2003 03:39:37 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:55823 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S264813AbTCEIjg>;
	Wed, 5 Mar 2003 03:39:36 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.64, IPv6] sleeping function called from illegal context
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
Date: Wed, 05 Mar 2003 09:29:55 +0100
Message-ID: <87k7fefc70.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The console output is:

Debug: sleeping function called from illegal context at
include/linux/rwsem.h:43
Call Trace:
 [<c0116478>] __might_sleep+0x54/0x5c
 [<c01cab41>] crypto_alg_lookup+0x21/0xc8
 [<c01cb971>] crypto_alg_mod_lookup+0xd/0x2c
 [<c01cacfd>] crypto_alloc_tfm+0x11/0xc0
 [<c02c1240>] __ipv6_regen_rndid+0xa0/0x1f4
 [<c01149fd>] wake_up_process+0xd/0x14
 [<c02c13c2>] ipv6_regen_rndid+0x2e/0xc4
 [<c011eeb9>] run_timer_softirq+0xf1/0x144
 [<c02c1394>] ipv6_regen_rndid+0x0/0xc4
 [<c011b761>] do_softirq+0x51/0xb0
 [<c010a230>] do_IRQ+0x114/0x130
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f54>] default_idle+0x0/0x34
 [<c0108ea0>] common_interrupt+0x18/0x20
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f7a>] default_idle+0x26/0x34
 [<c0107009>] cpu_idle+0x35/0x44
 [<c0105000>] rest_init+0x0/0x5c
 [<c0105055>] rest_init+0x55/0x5c

__ipv6_regen_rndid(): too short regeneration interval; timer diabled
for eth0.

-- 
#include <~/.signature>: permission denied
