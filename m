Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268904AbRHKXwi>; Sat, 11 Aug 2001 19:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRHKXw1>; Sat, 11 Aug 2001 19:52:27 -0400
Received: from [24.64.63.13] ([24.64.63.13]:17085 "EHLO
	smail-cal.shawcable.com") by vger.kernel.org with ESMTP
	id <S268902AbRHKXwQ>; Sat, 11 Aug 2001 19:52:16 -0400
Date: Sat, 11 Aug 2001 16:53:24 -0700 (PDT)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: Re: [Emu10k1-devel] [PATCH] EMU10K1: Juha Rjola's AC3 Passthrough for
In-Reply-To: <E15ViCM-0003Xa-00@the-village.bc.nu>
X-X-Sender: <d_bertra@kilrogg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Daniel T. Chen" <crimsun@email.unc.edu>, linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>
Message-id: <Pine.LNX.4.33.0108111637080.1234-100000@kilrogg>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have ac97 volumes _and_ other volumes handle with emu10k1 code. We want
to use the ac97_codec functions for it's OSS mixer handling for both
(storing volumes values, handling queries, etc). Those simple 2 lines
allow us to do that. Else, we have to intercept everything and write our
own functions to handle it.


On Sun, 12 Aug 2001, Alan Cox wrote:

> > For non-ac97 volume controls to work, the following needs to be added to
> > ac97_codec.c (or else the codec gets reset as the module tries to write a
> > volume to 0x00):
>
> I disagree. If you have a non ac97 codec you shouldnt be calling into
> ac97_codec.c in the first place
>

-- 
Daniel Bertrand

