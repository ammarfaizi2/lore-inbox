Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbTC1WVX>; Fri, 28 Mar 2003 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263176AbTC1WVX>; Fri, 28 Mar 2003 17:21:23 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:20915 "EHLO cruftix")
	by vger.kernel.org with ESMTP id <S263175AbTC1WVP>;
	Fri, 28 Mar 2003 17:21:15 -0500
Date: Fri, 28 Mar 2003 16:31:40 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: CS4236+ can't build [2.5.66-bk4]
Message-ID: <20030328223140.GB30134@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors when trying to build
  2.5.66-bk4 with the CS4236+ sound card:

  gcc -Wp,-MD,sound/isa/cs423x/.cs4236_lib.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium2 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cs4236_lib -DKBUILD_MODNAME=snd_cs4236_lib -c -o sound/isa/cs423x/cs4236_lib.o sound/isa/cs423x/cs4236_lib.c
sound/isa/cs423x/cs4236_lib.c: In function `snd_cs4236_create':
sound/isa/cs423x/cs4236_lib.c:287: warning: long unsigned int format, int arg (arg 2)
sound/isa/cs423x/cs4236_lib.c:287: warning: long unsigned int format, int arg (arg 2)
  gcc -Wp,-MD,sound/isa/cs423x/.cs4236.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium2 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cs4236 -DKBUILD_MODNAME=snd_cs4236 -c -o sound/isa/cs423x/cs4236.o sound/isa/cs423x/cs4236.c
sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_isapnp':
sound/isa/cs423x/cs4236.c:289: warning: implicit declaration of function `isapnp_find_dev'
sound/isa/cs423x/cs4236.c:289: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:290: structure has no member named `active'
sound/isa/cs423x/cs4236.c:294: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:295: structure has no member named `active'
sound/isa/cs423x/cs4236.c:300: warning: assignment makes pointer from integer without a cast
sound/isa/cs423x/cs4236.c:301: structure has no member named `active'
sound/isa/cs423x/cs4236.c:309: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:312: warning: implicit declaration of function `isapnp_resource_change'
sound/isa/cs423x/cs4236.c:323: structure has no member named `activate'
sound/isa/cs423x/cs4236.c:341: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:342: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:347: structure has no member named `activate'
sound/isa/cs423x/cs4236.c:349: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:358: structure has no member named `prepare'
sound/isa/cs423x/cs4236.c:359: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:360: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:367: structure has no member named `activate'
sound/isa/cs423x/cs4236.c: In function `snd_card_cs4236_deactivate':
sound/isa/cs423x/cs4236.c:388: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:392: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c:396: structure has no member named `deactivate'
sound/isa/cs423x/cs4236.c: In function `alsa_card_cs423x_init':
sound/isa/cs423x/cs4236.c:590: warning: implicit declaration of function `isapnp_probe_cards'
make[3]: *** [sound/isa/cs423x/cs4236.o] Error 1
make[2]: *** [sound/isa/cs423x] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2

This has been ongoing since the 2.5.50's; whom do I have to poke, or
  what do I need to know to fix it myself?

Thanks!
