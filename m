Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266563AbUBESxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUBESxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:53:30 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:24459 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266563AbUBESx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:53:27 -0500
Date: Thu, 5 Feb 2004 19:53:45 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 1.0.2c
In-Reply-To: <40228BB0.9020606@gmx.de>
Message-ID: <Pine.LNX.4.58.0402051952550.1864@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0402051838460.1864@pnote.perex-int.cz>
 <40228BB0.9020606@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004, Prakash K. Cheemplavam wrote:

> Jaroslav Kysela wrote:
> > Linus, please do a
> > 
> >   bk pull http://linux-sound.bkbits.net/linux-sound
> > 
> > The GNU patch is available at:
> > 
> >   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-02-05.patch.gz
> 
> Doesn't build for me:
> 
>    LD      sound/parisc/built-in.o
>    CC      sound/pci/intel8x0.o
> sound/pci/intel8x0.c: In function `alsa_card_intel8x0_setup':
> sound/pci/intel8x0.c:2817: error: Syntaxfehler before "get_option"
> sound/pci/intel8x0.c:2824: error: Syntaxfehler before ')' token
> make[2]: *** [sound/pci/intel8x0.o] Fehler 1
> make[1]: *** [sound/pci] Fehler 2
> make: *** [sound] Fehler 2

Obvious copy bug:

Index: intel8x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0.c,v
retrieving revision 1.112
retrieving revision 1.113
diff -u -r1.112 -r1.113
--- intel8x0.c	5 Feb 2004 13:28:42 -0000	1.112
+++ intel8x0.c	5 Feb 2004 18:48:04 -0000	1.113
@@ -2813,7 +2813,7 @@
 	(void)(get_option(&str,&enable[nr_dev]) == 2 &&
 	       get_option(&str,&index[nr_dev]) == 2 &&
 	       get_id(&str,&id[nr_dev]) == 2 &&
-	       get_option(&str,&ac97_clock[nr_dev]) == 2
+	       get_option(&str,&ac97_clock[nr_dev]) == 2 &&
 	       get_option(&str,&ac97_quirk[nr_dev]) == 2
 #ifdef SUPPORT_MIDI
 	       && get_option(&str,&mpu_port[nr_dev]) == 2

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
