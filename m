Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263900AbTCUTLV>; Fri, 21 Mar 2003 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263888AbTCUTJ7>; Fri, 21 Mar 2003 14:09:59 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:45830 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S263874AbTCUTJD>;
	Fri, 21 Mar 2003 14:09:03 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.65] tun not working
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
Date: Fri, 21 Mar 2003 20:13:08 +0100
Message-ID: <873clgh6t7.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using tun to connect my virtual S/390 from hercules to the local
machine.  That works pretty well with 2.4, but with 2.5.65 hercules
fails with:

root@gswi1164:~# hercules -f /etc/hercules/hercules.cnf
Hercules Version 2.16.5
(c)Copyright 1999-2002 by Roger Bowler, Jan Jaeger, and others
Built on Jul  9 2002 at 23:09:56
Build information:
  Debian
  Modes: S/370 ESA/390 ESAME
  Using setresuid() for setting privileges
  HTTP Server support

Running on Linux i686 2.5.65 #1 Thu Mar 20 19:11:34 CET 2003
ckddasd: /mount/d/hercules/linux.191 cyls=300 heads=15 tracks=4500
trklen=47616
HHC894I Error setting MTU for tun: No such device
HHC897I Error setting driving system IP addr for tun: No such device
HHC897I Error setting Hercules IP addr for tun: No such device
HHC897I Error setting netmask for tun: No such device
HHC898I Error getting flags for tun: No such device
HHC848I 0400 configuration failed: hercifc rc=4
HHC038I Initialization failed for device 0400

hercules uses /dev/net/tun to access the tun device.

The module tun is loaded:

dmesg:
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky

root@gswi1164:~# lsmod | grep tun
tun                     6240  0

Any idea why this fails?

Jochen

-- 
#include <~/.signature>: permission denied
