Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVHAQJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVHAQJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVHAQJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:09:30 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:59822 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S262249AbVHAQJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:09:05 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Date: Mon, 1 Aug 2005 19:07:31 +0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122852234.13000.27.camel@mindpipe> <dckikj$e8$1@sea.gmane.org>
In-Reply-To: <dckikj$e8$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200508011907.32116.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 August 2005 09:19, Stefan Seyfried wrote:

> > Any idea what their official recommendation for people running apps that
> > require the 1ms sleep resolution is?  Something along the lines of "Get
> > bent"?
> 
> MPlayer is using /dev/rtc and was running smooth for me since the good
> old 2.4 days.

MPlayer cares more about unbroken sound drivers, since the video needs
to run at the speed of your sound boards oscillator if you don't want sound
and video to run at different rates.
Unfortunately people use an almost random mix of alsa, alsa-lib and .asoundrc
setups, including me, mplayer through dmix is one jitter-fest, mplayer straight
to the alsa pcm device works better, but of course using the oss emulation
seems to work best of all :-)

I never noticed any difference during 2.4 between using rtc and not using rtc.
