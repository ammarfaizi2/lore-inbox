Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUCPN2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUCPN2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:28:09 -0500
Received: from math.ut.ee ([193.40.5.125]:59616 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261501AbUCPN2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:28:05 -0500
Date: Tue, 16 Mar 2004 15:28:00 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sound core broken on sparc64 (2.6.4+bk)
In-Reply-To: <s5hllm2gewj.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0403161513470.29946-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the attached patch should fix.

Yes, thanks! This is also fixed in mainline by now.

Ths leads me to the next error:

sound/sparc/cs4231.c: In function `snd_cs4231_pcm':
sound/sparc/cs4231.c:1573: error: `SNDRV_DMA_TYPE_PCI' undeclared (first use in this function)
sound/sparc/cs4231.c:1573: error: (Each undeclared identifier is reported only once
sound/sparc/cs4231.c:1573: error: for each function it appears in.)
sound/sparc/cs4231.c:1575: error: parse error before numeric constant

SNDRV_DMA_TYPE_PCI used to be defined in <sound/memalloc.h> but is now
gone.

-- 
Meelis Roos (mroos@linux.ee)

