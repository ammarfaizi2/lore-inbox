Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTABXoD>; Thu, 2 Jan 2003 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267324AbTABXoD>; Thu, 2 Jan 2003 18:44:03 -0500
Received: from [62.233.169.82] ([62.233.169.82]:6945 "HELO
	mother.fordon.pl.eu.org") by vger.kernel.org with SMTP
	id <S267322AbTABXoA>; Thu, 2 Jan 2003 18:44:00 -0500
Date: Fri, 3 Jan 2003 00:52:33 +0100
From: "Tomasz Torcz, BG" <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2 netcards related/PnP compile failures in 2.5.54
Message-ID: <20030102235233.GA24918@irc.pl>
Mail-Followup-To: "Tomasz Torcz, BG" <zdzichu@irc.pl>,
	linux-kernel@vger.redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I've just tried to compile 2.5.54 only to get compilation failure:

  gcc -Wp,-MD,drivers/net/.ne.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ne -DKBUILD_MODNAME=ne   -c -o drivers/net/ne.o drivers/net/ne.c
drivers/net/ne.c: In function `ne_probe_isapnp':
drivers/net/ne.c:201: warning: implicit declaration of function `isapnp_find_dev'
drivers/net/ne.c:204: warning: assignment makes pointer from integer without a cast
drivers/net/ne.c:206: dereferencing pointer to incomplete type
drivers/net/ne.c:208: dereferencing pointer to incomplete type
drivers/net/ne.c:211: dereferencing pointer to incomplete type
drivers/net/ne.c:214: dereferencing pointer to incomplete type
drivers/net/ne.c:215: dereferencing pointer to incomplete type
drivers/net/ne.c: In function `cleanup_module':
drivers/net/ne.c:788: dereferencing pointer to incomplete type
make[2]: *** [drivers/net/ne.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


so I went to kernel config and enabled everything related to Plug'n'Play.
I've got another error:

  gcc -Wp,-MD,drivers/net/.3c509.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3c509 -DKBUILD_MODNAME=3c509   -c -o drivers/net/3c509.o drivers/net/3c509.c
drivers/net/3c509.c: In function `el3_probe':
drivers/net/3c509.c:361: warning: implicit declaration of function `isapnp_find_dev'
drivers/net/3c509.c:364: warning: assignment makes pointer from integer without a cast
drivers/net/3c509.c:365: dereferencing pointer to incomplete type
drivers/net/3c509.c:368: dereferencing pointer to incomplete type
drivers/net/3c509.c:369: dereferencing pointer to incomplete type
drivers/net/3c509.c:370: dereferencing pointer to incomplete type
drivers/net/3c509.c:370: dereferencing pointer to incomplete type
drivers/net/3c509.c:372: dereferencing pointer to incomplete type
drivers/net/3c509.c:375: dereferencing pointer to incomplete type
make[2]: *** [drivers/net/3c509.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


so no 2.5.54 for me. I wish I could check if matroxfb finally works again.
(gcc 2.95.3)


BTW - since about ten kernel versions shutting down system fails.
After "INIT: Sending all processess KILL signal" nothing more 
happens. I can switch consoles, syslogd still works but init
appears to hang. How to check what's going on?
-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated.
"Funeral in the morning, IDE hacking in the afternoon and evening." - Alan Cox
