Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSFIRpc>; Sun, 9 Jun 2002 13:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSFIRpb>; Sun, 9 Jun 2002 13:45:31 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:63918
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314080AbSFIRp1>; Sun, 9 Jun 2002 13:45:27 -0400
Date: Sun, 9 Jun 2002 10:45:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Lane <miles@megapathdsl.net>
Cc: "Skip Ford <skip.ford@verizon.net,LKML" 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21 -- emumpu401.c:309: parse error before "emu10k1_midi_init"
Message-ID: <20020609174502.GS14252@opus.bloom.county>
In-Reply-To: <20020609084334.HNHE24507.pop016.verizon.net@pool-141-150-239-239.delv.east.verizon.net> <3D038E60.7030105@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 10:20:32AM -0700, Miles Lane wrote:
> Skip Ford wrote:
> >
> > I guess this file also needs init.h
> >
> >
> > --- linux/sound/pci/emu10k1/emumpu401.c~        Sun Jun  9 04:30:46 2002
> > +++ linux/sound/pci/emu10k1/emumpu401.c Sun Jun  9 04:31:51 2002
> > @@ -22,6 +22,7 @@
> >  #define __NO_VERSION__
> >  #include <sound/driver.h>
> >  #include <linux/time.h>
> > +#include <linux/init.h>
> >  #include <sound/core.h>
> >  #include <sound/emu10k1.h>
> 
> After applying your patch, I get:
> 
>   gcc -Wp,-MD,.emupcm.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon  -nostdinc -iwithprefix include -DMODULE 
> -DKBUILD_BASENAME=emupcm   -c -o emupcm.o emupcm.c
> emupcm.c:964: parse error before "snd_emu10k1_pcm"
> emupcm.c:965: warning: return type defaults to `int'
> emupcm.c:1012: parse error before "snd_emu10k1_pcm_mic"
> emupcm.c:1013: warning: return type defaults to `int'
> emupcm.c:1115: parse error before "snd_emu10k1_pcm_efx"
> emupcm.c:1116: warning: return type defaults to `int'
> make[3]: *** [emupcm.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/sound/pci/emu10k1'

emupcm.c needs <linux/init.h> as well.  And probably a few more files in
there as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
