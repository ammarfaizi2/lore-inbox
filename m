Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVGLM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGLM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVGLM1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:27:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261306AbVGLMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:25:24 -0400
Date: Tue, 12 Jul 2005 14:25:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: saa7134 card no longer working
Message-ID: <20050712122522.GB4034@stusta.de>
References: <20050710165839.GQ28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710165839.GQ28243@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
This problem is fixed in 2.6.13-rc2-mm2.


On Sun, Jul 10, 2005 at 06:58:39PM +0200, Adrian Bunk wrote:
> Hi,
> 
> I observed the following problem with a Tevion MD 9717 card:
> 
> It works in 2.6.12-rc6-mm1, but AFAIR this was the last kernel where it 
> worked, in more recent kernels (including 2.6.13-rc2-mm1) tvtime only 
> says "no signal".
> 
> dmesg output with 2.6.12-rc6-mm1:
> saa7134[0]: found at 0000:00:0a.0, rev: 1, irq: 6, latency: 32, mmio: 0xcfffcc00
> saa7134[0]: subsystem: 1131:0000, board: Tevion MD 9717 [card=6,insmod option]
> saa7134[0]: board init: gpio is 100a0
> saa7134[0]: Huh, no eeprom present (err=-5)?
> saa7134[0]: registered device video0 [v4l2]
> saa7134[0]: registered device vbi0
> saa7134[0]: registered device radio0
> tuner 4-0060: chip found @ 0xc0 (saa7134[0])
> tuner 4-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
> 
> In 2.6.13-rc2-mm1 there's an additional line
> tuner 4-0060: All bytes are equal. It is not a TEA5767
> 
> I'm always saying "saa7134.card=6" at the kernel command line since I 
> got a "no eeprom present" message from the driver without this.
> 
> The card is working with 2.6.12-rc6-mm1, but during running, I 
> occasionally get the following message in the syslog:
> saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [last detected]
> 
> cu
> Adrian
