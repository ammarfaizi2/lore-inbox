Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSFIInj>; Sun, 9 Jun 2002 04:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSFIIni>; Sun, 9 Jun 2002 04:43:38 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:17131 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S317578AbSFIIni>; Sun, 9 Jun 2002 04:43:38 -0400
Date: Sun, 9 Jun 2002 04:48:38 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.21 -- emumpu401.c:309: parse error before "emu10k1_midi_init"
In-Reply-To: <1023607481.5775.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020609084334.HNHE24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
>   gcc -Wp,-MD,.emumpu401.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=emumpu401   -c -o emumpu401.o emumpu401.c
> emumpu401.c:309: parse error before "emu10k1_midi_init"
> emumpu401.c:310: warning: return type defaults to `int'
> emumpu401.c:332: parse error before "snd_emu10k1_midi"
> emumpu401.c:333: warning: return type defaults to `int'
> emumpu401.c:349: parse error before "snd_emu10k1_audigy_midi"
> emumpu401.c:350: warning: return type defaults to `int'
> make[3]: *** [emumpu401.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/sound/pci/emu10k1'

I guess this file also needs init.h


--- linux/sound/pci/emu10k1/emumpu401.c~	Sun Jun  9 04:30:46 2002
+++ linux/sound/pci/emu10k1/emumpu401.c	Sun Jun  9 04:31:51 2002
@@ -22,6 +22,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 

-- 
Skip
