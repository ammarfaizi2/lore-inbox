Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270380AbUJTNvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270380AbUJTNvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270201AbUJTNsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:48:41 -0400
Received: from mail1.epfl.ch ([128.178.7.12]:48650 "HELO mail1.epfl.ch")
	by vger.kernel.org with SMTP id S270205AbUJTNoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:44:19 -0400
Date: Wed, 20 Oct 2004 15:44:16 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: AC3 passtrough under 2.6.9 with SBlive
Message-ID: <20041020134416.GA13034@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

all 2.6.9 don't work regarding AC3 passtrough on my SBlive, someone
under #ALSA in irc give me a small patch that make is works:

--- emupcm.c	16 Sep 2004 10:36:44 -0000	1.32
+++ emupcm.c	30 Sep 2004 10:06:53 -0000	1.33
@@ -1192,7 +1192,7 @@
 	}
 	snd_emu10k1_fx8010_playback_tram_poke1((unsigned short *)emu->fx8010.etram_pages.area + tram_pos,
  					       (unsigned short *)emu->fx8010.etram_pages.area + tram_pos + tram_size / 2,
-					       src, frames, tram_shift++);
+					       src, frames, tram_shift);
 	tram_pos -= frames;
 	pcm->tram_pos = tram_pos;
 	pcm->tram_shift = tram_shift;

It's fixed in the ALSA CVS, but it would be nice if that one could
already goes in next release :-)
-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
