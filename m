Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVAJMAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVAJMAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVAJMAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:00:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58521 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262219AbVAJMAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:00:20 -0500
X-Envelope-From: kraxel@bytesex.org
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bttv/v4l2/Linux 2.6.10-ac8: xawtv hanging in videobuf_waiton
References: <20050110000043.GA9549@m.safari.iki.fi>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 10 Jan 2005 12:35:33 +0100
In-Reply-To: <20050110000043.GA9549@m.safari.iki.fi>
Message-ID: <871xct1pq2.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin <7atbggg02@sneakemail.com> writes:

> when I start xawtv and alevt in the same window and press 'v' in xawtv,
> bttv goes berserk, producing around 25 lines per second of debug stuffs.
> (xawtv was also in fullscreen mode when I did this).
> alevt quits just fine.
> 
> Jan 10 00:43:26 safari kernel: bttv0: OCERR @ 0d1f9014,bits: HSYNC OFLOW OCERR*
> Jan 10 00:43:26 safari last message repeated 11 times
> Jan 10 00:43:26 safari kernel: bttv0: timeout: drop=0 irq=7236/7236, risc=0d1f901c, bits: HSYNC OFLOW
> Jan 10 00:43:26 safari kernel: bttv0: reset, reinitialize
> Jan 10 00:43:26 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
> Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*

Any change with latest updates from http://dl.bytesex.org/patches/ ?

I can reproduce with the latest bits.  There was a state handling bug
when using both video + vbi recently through, not sure whenever the
fix made it into 2.6.10 or not.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
