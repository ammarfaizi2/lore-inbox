Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbSLKNbk>; Wed, 11 Dec 2002 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbSLKNbk>; Wed, 11 Dec 2002 08:31:40 -0500
Received: from [81.2.122.30] ([81.2.122.30]:21508 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267145AbSLKNbi>;
	Wed, 11 Dec 2002 08:31:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212111347.gBBDl0Pd007751@darkstar.example.net>
Subject: Re: 2.5.51 breaks ALSA AWE32
To: sam@ravnborg.org (Sam Ravnborg)
Date: Wed, 11 Dec 2002 13:47:00 +0000 (GMT)
Cc: perex@suse.cz, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
In-Reply-To: <20021210205321.GA2321@mars.ravnborg.org> from "Sam Ravnborg" at Dec 10, 2002 09:53:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > make -f scripts/Makefile.build obj=sound/synth/emux
> >    ld -m elf_i386  -r -o sound/synth/built-in.o sound/synth/emux/built-in.o
> > ld: cannot open sound/synth/emux/built-in.o: No such file or directory
> > make[2]: *** [sound/synth/built-in.o] Error 1
> > make[1]: *** [sound/synth] Error 2
> > make: *** [sound] Error 2
> 
> kbuild in 2.5.51 requires that there exist one variable named obj-*
> before built-in.o is generated.
> In the Makefile for sound/synth/emux the variables obj-* is only set if
> CONFIG_SND_SEQUENCER is set to y or m.
> 
> The best approach may be a derived bool defined in Kconfig, but
> an alterneative solution is to rearrange the Makefile a bit.
> 
> Try the following (untested) patch.

Same error I'm afraid :-/

John.
