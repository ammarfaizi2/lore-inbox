Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbSLJKMT>; Tue, 10 Dec 2002 05:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbSLJKMT>; Tue, 10 Dec 2002 05:12:19 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:53766 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266746AbSLJKMS> convert rfc822-to-8bit;
	Tue, 10 Dec 2002 05:12:18 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.51, OSS] compile error
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
Date: Tue, 10 Dec 2002 11:01:45 +0100
Message-ID: <87k7iimbue.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This seems to be a result of the PCI patches:

  gcc -Wp,-MD,sound/oss/.cs4232.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=cs4232 -DKBUILD_MODNAME=cs4232   -c -o sound/oss/cs4232.o sound/oss/cs4232.c
sound/oss/cs4232.c:361: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c:362: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c:365: unknown field `driver_data' specified in initializer
sound/oss/cs4232.c: In function `cs4232_pnp_probe':
sound/oss/cs4232.c:389: warning: passing arg 1 of `pci_set_drvdata' from incompatible pointer type
sound/oss/cs4232.c: In function `cs4232_pnp_remove':
sound/oss/cs4232.c:395: structure has no member named `driver_data'
sound/oss/cs4232.c: At top level:
sound/oss/cs4232.c:402: unknown field `card_id_table' specified in initializer
sound/oss/cs4232.c:403: duplicate initializer
sound/oss/cs4232.c:403: (near initialization for `cs4232_driver.id_table')
sound/oss/cs4232.c:404: warning: initialization from incompatible pointer type
sound/oss/cs4232.c:327: warning: `synthirq' defined but not used
make[3]: *** [sound/oss/cs4232.o] Fehler 1

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
