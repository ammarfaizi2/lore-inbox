Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282664AbRLLWYF>; Wed, 12 Dec 2001 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLLWXz>; Wed, 12 Dec 2001 17:23:55 -0500
Received: from [216.151.155.121] ([216.151.155.121]:15633 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S282664AbRLLWXq>; Wed, 12 Dec 2001 17:23:46 -0500
To: zlatko.calusic@iskon.hr
Cc: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>,
        Rui Sousa <rui.p.m.sousa@clix.pt>,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
	<3C175A7C.6C532320@roadnet.com.br> <878zc8az65.fsf@atlas.iskon.hr>
From: Doug McNaught <doug@wireboard.com>
Date: 12 Dec 2001 17:23:37 -0500
In-Reply-To: Zlatko Calusic's message of "12 Dec 2001 22:47:30 +0100"
Message-ID: <m3n10ot6vq.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic <zlatko.calusic@iskon.hr> writes:

> Yes, nice idea, but easier said than done. :)
> 
> Unfortunately esd is started by the gnome desktop environment and I
> can disable or enable it, but can't set any parameters (as far as I
> can see). Probably I'll disable it for good, as emu10k1 driver already
> does a great job mixing multiple sound streams.

There's always the hack...

# cd /usr/bin
# mv esd esd.real
# cat >>esd
#!/bin/sh
exec esd.real -as 10 $*
^D
# chmod 755 esd

;)

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
