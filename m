Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273829AbRI3RkR>; Sun, 30 Sep 2001 13:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273832AbRI3RkH>; Sun, 30 Sep 2001 13:40:07 -0400
Received: from [213.37.2.230] ([213.37.2.230]:32712 "EHLO
	villaverde.madritel.es") by vger.kernel.org with ESMTP
	id <S273829AbRI3Rjy>; Sun, 30 Sep 2001 13:39:54 -0400
To: linux-kernel@vger.kernel.org
Subject: Cannot unload some modules
Message-Id: <E15mbcJ-0001Hd-00@DervishD>
Date: Thu, 27 Sep 2001 15:54:19 +0200
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    I have a problem with some modules, specially with 'dummy.o' (the
dummy network device driver) and some USB ones: they aren't unloaded,
even when unused and autocleanable, issuing two or more 'rmmod -a'
commands.

    This leaded me to think that the 'cleanup()' functions of those
modules did hang, but the modules are correctly unloaded if called by
their name in rmmod, but no if 'rmmod -a' is used :((

    I've took a look at 'module.c' and I'm clueless. I've checked the
modules and are loaded with 'modprobe -k', are marked as
autocleanable and marked as unused, too.

    BTW, I've noticed too that the serial module sometimes has a
negative value in its 'use' count :!!

    Can anybody tell me what could be happening?. Thanks a lot.

    Raúl
