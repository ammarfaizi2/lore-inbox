Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWAQSFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWAQSFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAQSFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:05:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932271AbWAQSFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:05:43 -0500
Subject: Re: Linux 2.6.16-rc1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <200601171125.40854.gene.heskett@verizon.net>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <200601171125.40854.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 Jan 2006 16:05:36 -0200
Message-Id: <1137521136.6446.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene,

	Please address these questions to V4L Mailing list, since it is the
better forum for this kind of discussions.

Em Ter, 2006-01-17 às 11:25 -0500, Gene Heskett escreveu:
> On Tuesday 17 January 2006 03:19, Linus Torvalds wrote:
> >Ok, it's two weeks since 2.6.15, and the merge window is closed.
> 
> Well, I sorta broke my never build an -rc1 rule.
> 
> It seems to be stable so far, but I have a cx88 based video card, a 
> pcHDTV-3000, and there's 2 problems with the audio.  That dma function 
> was turned off in the .config as the lspci -n didn't report the right 
> numbers.
	To enable cx88-alsa, you need to have alsa enabled at kernel.

	Not all devices supports digital audio on cx2388x. There's a bit at
board's eeprom specifying if digital audio is provided by the board. If
this bit is set, you will see 1741:8801 or 1741:8811 with lspci -n.
If your device doesn't show these numbers, the module will not work.

> 
> 1. tvtimes volume control has no effect, in kamix, its now the 'front' 
> slider.  Its actually plugged into the line in jack of a SBLive Audigy 
> 2 Value card.
	This is not a kernel question. Anyway, tvtime config file have a field
specifying which input line is selected.
> 
> 2. The audio has a definite 'dragging voice coil' sound, very tiresome 
> to listen to, highly clipped regardless of the gain settings.
	We need more info about this, like video and audio standard, audio mode
(mono, stereo, sap), what device, dmesg. Please provide these info to
v4l ml and we will be happy to help you.
> 
> Since I do watch tv on this box, I'll go back to 2.6.15.1 until -rc2 is 
> released.
> 
Cheers, 
Mauro.

