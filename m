Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXXp3>; Wed, 24 Jan 2001 18:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRAXXpT>; Wed, 24 Jan 2001 18:45:19 -0500
Received: from jalon.able.es ([212.97.163.2]:5847 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129413AbRAXXpJ>;
	Wed, 24 Jan 2001 18:45:09 -0500
Date: Thu, 25 Jan 2001 00:44:54 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: warning in 2.4.1pre10
Message-ID: <20010125004454.C930@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches end of
non-void function

It is harmless, 'cause the last sentence in the funtion is a panic, but it
is good to add the 'return 0', just to shut up the compiler.

The same happens in the aic7xxx drivers v 6.0.9b, file aic7xxx_linux.h, line
824.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-pre10 #4 SMP Wed Jan 24 00:20:15 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
