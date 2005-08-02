Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVHBO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVHBO71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVHBO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:59:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:387 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261565AbVHBO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:58:24 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050802091313.GB6724@irc.pl>
References: <1122746718.14769.4.camel@mindpipe>
	 <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe>
	 <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu>
	 <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu>
	 <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe>
	 <dckikj$e8$1@sea.gmane.org>  <20050802091313.GB6724@irc.pl>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 10:58:21 -0400
Message-Id: <1122994702.5490.54.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 11:13 +0200, Tomasz Torcz wrote:
> On Mon, Aug 01, 2005 at 08:19:42AM +0200, Stefan Seyfried wrote:
> > Lee Revell wrote:
> > > On Mon, 2005-08-01 at 00:47 +0200, Pavel Machek wrote:
> > >> I'm pretty sure at least one distro will go with HZ<300 real soon now
> > >> ;-).
> > >> 
> > > 
> > > Any idea what their official recommendation for people running apps that
> > > require the 1ms sleep resolution is?  Something along the lines of "Get
> > > bent"?
> > 
> > MPlayer is using /dev/rtc and was running smooth for me since the good
> > old 2.4 days.
> 
>  VMware also uses /dev/rtc. So is NTP, which is needed when time drifts.
> But they can't use /dev/rtc simultanously, as it's single-open device.
> So running ntpd denies vmware and mplayer access to RTC. Bummer.
> 

You could work around this to some extent by using the ALSA timer API
with the RTC timer.  I think this allows multiple open by setting the
RTC to tick based on the lowest common denominator.  It won't help
vmware and NTP though.

Lee

