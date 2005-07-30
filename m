Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVG3SGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVG3SGN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVG3SGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:06:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9379 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263092AbVG3SFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:05:19 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122678943.9381.44.camel@mindpipe>
	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 14:05:17 -0400
Message-Id: <1122746718.14769.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 12:06 +0200, Marc Ballarin wrote:
> On Fri, 29 Jul 2005 19:15:42 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > 
> > What kind of results do you get with a more realistic setup, like
> > running KDE or Gnome OOTB?
> > 
> 
> Here are results with KDE running.
> 
> - no peripherals attached, i.e. truly mobile setup.
> - all modules loaded
> - klaptopdaemon disabled in order to eliminate competition in polling the
>   already slow battery controller
> - furthermore, I found that artsd prevents entering C3 and generally
>   increases power consumption (ALSA, snd_intel8x0)
> - voltage is 16.5V

> HZ=100:                   HZ=1000:      DIFF:
> 
> 1) averages:
> 
> backlight off, arstd off:
> 637.17                    679.67        42.5

> backlight off, artsd on:
> 799.46                    806.13        6.67

So it looks like artsd wastes way more power DMAing a bunch of silent
pages to the sound card than HZ=1000.

There's nothing the ALSA layer can do about this, it's a KDE bug.

I think this is a good argument for leaving HZ at 1000 until some of
these userspace bugs are fixed.

Lee

