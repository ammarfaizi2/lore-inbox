Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRIMQra>; Thu, 13 Sep 2001 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271858AbRIMQrR>; Thu, 13 Sep 2001 12:47:17 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:18181 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271861AbRIMQqx>; Thu, 13 Sep 2001 12:46:53 -0400
Date: Thu, 13 Sep 2001 18:45:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 11/11] WaveFront timing fix for x86-64
Message-ID: <20010913184541.A2651@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds necessary timing support for x86-64 into the wavefront
driver.

This is the last patch of the series.

Thanks for your attention.

Vojtech

diff -urN linux-x86_64/drivers/sound/wavfront.c linux/drivers/sound/wavfront.c
--- linux-x86_64/drivers/sound/wavfront.c	Thu Sep 13 15:17:33 2001
+++ linux/drivers/sound/wavfront.c	Tue Sep 11 09:49:17 2001
@@ -101,6 +101,10 @@
 #if defined(__i386__)
 #define LOOPS_PER_TICK current_cpu_data.loops_per_jiffy
 #endif
+
+#if defined(__x86_64__)
+#define LOOPS_PER_TICK	loops_per_jiffy
+#endif
  
 #define _MIDI_SYNTH_C_
 #define MIDI_SYNTH_NAME	"WaveFront MIDI"

-- 
Vojtech Pavlik
SuSE Labs
