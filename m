Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTDGAsX (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 20:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTDGAsX (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 20:48:23 -0400
Received: from www.wotug.org ([194.106.52.201]:21370 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id S263170AbTDGAsW (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 20:48:22 -0400
Date: Mon, 7 Apr 2003 02:01:40 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7: ac97 audio compile errors
Message-ID: <Pine.LNX.4.44.0304070158120.8701-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated from pre6 to pre7 using the incremental patch. This reveals
following error (not present in pre6):

gcc -D__KERNEL__ -I/home/extra/2.4.21/linux/include -Wall -Wstrict-prototypes
	-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
	-mpreferred-stack-boundary=2 -march=athlon -nostdinc -iwithprefix include
	-DKBUILD_BASENAME=ac97_codec -DEXPORT_SYMTAB -c ac97_codec.c
ac97_codec.c:131: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:131: initializer element is not constant
ac97_codec.c:131: (near initialization for `ac97_codec_ids[12].flags')
ac97_codec.c:132: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:132: initializer element is not constant
ac97_codec.c:132: (near initialization for `ac97_codec_ids[13].flags')
ac97_codec.c:133: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:133: initializer element is not constant
ac97_codec.c:133: (near initialization for `ac97_codec_ids[14].flags')
ac97_codec.c:144: `AC97_DELUDED_MODEM' undeclared here (not in a function)
ac97_codec.c:144: initializer element is not constant
ac97_codec.c:144: (near initialization for `ac97_codec_ids[25].flags')
ac97_codec.c: In function `ac97_probe_codec':
ac97_codec.c:763: structure has no member named `modem'
ac97_codec.c:774: structure has no member named `flags'
ac97_codec.c:780: structure has no member named `flags'
ac97_codec.c:780: `AC97_DELUDED_MODEM' undeclared (first use in this function)
ac97_codec.c:780: (Each undeclared identifier is reported only once
ac97_codec.c:780: for each function it appears in.)
ac97_codec.c:781: structure has no member named `modem'
ac97_codec.c:786: structure has no member named `modem'
ac97_codec.c: In function `ac97_init_mixer':
ac97_codec.c:808: structure has no member named `flags'
ac97_codec.c:808: `AC97_NO_PCM_VOLUME' undeclared (first use in this function)
ac97_codec.c:839: structure has no member named `flags'
make[3]: *** [ac97_codec.o] Error 1

A search of the kernel tree reveals no definition of AC97_NO_PCM_VOLUME. Is 
there a patch?

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

