Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbTDBSTa>; Wed, 2 Apr 2003 13:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbTDBSTa>; Wed, 2 Apr 2003 13:19:30 -0500
Received: from carmel.ip.tiscali.net ([213.200.88.197]:8710 "EHLO
	carmel.ip.tiscali.net") by vger.kernel.org with ESMTP
	id <S263118AbTDBSTZ>; Wed, 2 Apr 2003 13:19:25 -0500
Date: Wed, 2 Apr 2003 20:30:35 +0200
From: Alexander Koch <efraim@clues.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sound, sb16, not compiling
Message-ID: <20030402183035.GA11887@shekinah.ip.tiscali.net>
References: <20030328144710.GA8522@shekinah.ip.tiscali.net> <Pine.LNX.4.50.0303281000370.2884-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303281000370.2884-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 March 2003 10:01:15 -0500, Zwane Mwaikambo wrote:
> > I fail to get the SB16 module compiled, it does not like me.
> > This is 2.5.66, .65 does not work either.
> > 
> > Hope anyone can help as I miss it. ;-)
> 
> There are about a bazillion patches out there to fix this, i'm not quite 
> sure when one of them will get in. Try searching the archives.

Yes, but the patch gives me a compile error with 2.6.67 and
I did not get any reply yet asking Adam Belay directly. My
compile error with the latest patch (I hope it is) is this:

-->
make -f scripts/Makefile.build obj=sound/isa/opti9xx
make -f scripts/Makefile.build obj=sound/isa/sb
  gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3
-Iinclude/asm-i386/mach-default -fomit-frame-pointer
-nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16
-c -o sound/isa/sb/sb16.o sound/isa/sb/sb16.c
sound/isa/sb/sb16.c:251: storage size of
`__mod_pnp_card_device_table' isn't known
make[3]: *** [sound/isa/sb/sb16.o] Error 1
make[2]: *** [sound/isa/sb] Error 2
make[1]: *** [sound/isa] Error 2
make: *** [sound] Error 2
<--

And it was not a bazillion patches, but some of them, yes.
Any takers?

Thanks,
Alexander

