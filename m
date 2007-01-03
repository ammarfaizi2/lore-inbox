Return-Path: <linux-kernel-owner+w=401wt.eu-S932143AbXACVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbXACVVs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbXACVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:21:48 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40155 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbXACVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:21:47 -0500
Message-ID: <459C1E71.5010805@drzeus.cx>
Date: Wed, 03 Jan 2007 22:21:53 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: emilus <emilus@galeria-m.art.pl>
CC: sdhci-devel <sdhci-devel@list.drzeus.cx>, Alex Dubov <oakad@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Sdhci-devel] sdhci ubuntu problem.
References: <1167089660.5837.6.camel@wpilap>  <45951D8D.2090200@drzeus.cx>	 <1167408325.4306.10.camel@wpilap>  <4597A4C5.8030008@drzeus.cx> <1167780471.3666.17.camel@localhost>
In-Reply-To: <1167780471.3666.17.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

emilus wrote:
> Uff... 
> I just change system back to debian because of other problems with
> Ubuntu.
> And suprise ... SD doesn't work! I'm very suprised...
> There was no problem before. Card reader works with 2GB cards too and
> everything was fine.
> So I have installed the newest kernel 2.6.19 without succes.
> but I found that there is a specific drivers for my TI (in 2.6.19) so I
>   

Ah... didn't notice that it was a TI controller you had. Then you
usually need an ugly setpci hack for it to work with sdhci. But the new
tifm_sd driver is the preferred solution.

> try it. And nothing better... but.
> when card is inserted in card reader at boot time sth. happen.
> I attach dmesg with it.
>   

As you have ndiswrapper rearing its ugly head just above, I would guess
it starts up your wlan card at interrupt 21 and kills it. I would
suggest trying without ndiswrapper loaded.

As this is now a tifm_sd related issue, I would recommend that Alex
Dubov takes over and the list of choice being the kernel mailing list
(both cc:d).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

