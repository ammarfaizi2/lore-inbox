Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQKOLX0>; Wed, 15 Nov 2000 06:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQKOLXG>; Wed, 15 Nov 2000 06:23:06 -0500
Received: from jalon.able.es ([212.97.163.2]:64468 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129652AbQKOLW6>;
	Wed, 15 Nov 2000 06:22:58 -0500
Date: Wed, 15 Nov 2000 11:52:50 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: net mods installed under misc in 2.2.18-pre21
Message-ID: <20001115115250.A1231@werewolf.able.es>
Reply-To: jamagallon@able.es
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

I have noticed that some kernel modules are installed under
/lib/modules/XXX/misc,
instead of /net. I have been checking the drivers/net/Makefile (little knowledge
of 
kernel make infraestructure...), and MOD_LIST_NAME is set properly, but the only
content of modules/NET_MODULES is dummy.o.

There is no important issue, but that i build newer net drivers got from Scyld,
and
installed them under modules/XXX/net. But modprobe was still getting the old
ones,
because 'misc' is before 'net'...

Kernel is plain standard kernel 2.2.17 + 2.2.18-pre21-patch + VM-patch + i2c-lm
patch.

I will dig into the makefiles, but someone has a clue ? Perhaps this also
affects
other modules.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
