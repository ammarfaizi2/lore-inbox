Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKGK2V>; Wed, 7 Nov 2001 05:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280419AbRKGK2L>; Wed, 7 Nov 2001 05:28:11 -0500
Received: from fandango.cs.unitn.it ([193.205.199.228]:32773 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S280387AbRKGK14> convert rfc822-to-8bit; Wed, 7 Nov 2001 05:27:56 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111071027.LAA24296@fandango.cs.unitn.it>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <20011107104405.A3168@emeraude.kwisatz.net> from Stephane Jourdois
 at "Nov 7, 2001 10:44:05 am"
To: stephane@tuxfinder.org
Date: Wed, 7 Nov 2001 11:27:46 +0100 (MET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now a fundamental question :
> Does the load of the i8k module inhibits the fans start ? I can see my
> processor temp increasing (I saw 80°C ...) without the fans start. Then
> I started i8kmon to avoid an explosion. If the modules inhibits material
> protections, then if that can be modified, it would be great ; if not,
> i8kmon needs to get included in the kernel as a daemon. The i8kmon
> should be a funny tool, not a system critical tool.

The i8k module itself doesn't interfere with the BIOS fan control.
It just adds some ioctl to allow fan control from user-space. The
real problem is that the BIOS fan control is broken, as everybody
who own an I8K knows very well. If you run i8kmon with the --noauto
option you will just see the temperature and fan status as managed
by the BIOS. The i8kmon does the same job as the BIOS but uses lower
thresholds. The only difference is is that my program works.

> Also, I couldn't understand why sometimes the left fan is printed on red
> color in i8kmon...

If it becomes red for a short time it may be that the fan is slow at
turning on. If the button stays red for long time it means that your fan
is broken or stuck. Try starting it manually with a bent paper clip and
see if the red disappears. This is explained in the i8kmon manpage.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
