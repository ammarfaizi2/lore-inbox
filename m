Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRHLAQx>; Sat, 11 Aug 2001 20:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRHLAQn>; Sat, 11 Aug 2001 20:16:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34571 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268702AbRHLAQa>; Sat, 11 Aug 2001 20:16:30 -0400
Subject: Re: [Emu10k1-devel] [PATCH] EMU10K1: Juha Rjola's AC3 Passthrough for
To: d.bertrand@ieee.org (Daniel Bertrand)
Date: Sun, 12 Aug 2001 01:18:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        crimsun@email.unc.edu (Daniel T. Chen), linux-kernel@vger.kernel.org,
        emu10k1-devel@opensource.creative.com (emu10k1-devel)
In-Reply-To: <Pine.LNX.4.33.0108111637080.1234-100000@kilrogg> from "Daniel Bertrand" at Aug 11, 2001 04:53:24 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VixX-0003b7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have ac97 volumes _and_ other volumes handle with emu10k1 code. We want
> to use the ac97_codec functions for it's OSS mixer handling for both
> (storing volumes values, handling queries, etc). Those simple 2 lines
> allow us to do that. Else, we have to intercept everything and write our
> own functions to handle it.

That is fine by me.

There are really two ways we approach this

1.	You add two methods for volume control into your code

2.	We make ac97_codec into audio_codec and we add things to the 
	codec_ops structure for volume and mixer control.

For 2.4 #1 seems a lot easier

