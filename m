Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267815AbTAMEcD>; Sun, 12 Jan 2003 23:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267819AbTAMEcD>; Sun, 12 Jan 2003 23:32:03 -0500
Received: from [216.222.206.4] ([216.222.206.4]:61845 "EHLO
	webmail.frogspace.net") by vger.kernel.org with ESMTP
	id <S267815AbTAMEcC>; Sun, 12 Jan 2003 23:32:02 -0500
Message-ID: <1042432838.3e22434654f74@webmail.cogweb.net>
Date: Sun, 12 Jan 2003 20:40:38 -0800
From: peter@cogweb.net
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Re: 2.4.19 -- ac97_codec failure ALi 5451
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 128.97.184.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Final status report

The trident driver in 2.4.20 is now working on the vpr matrix 200a5 laptop with an
ALi5451 PCI soundcard. Remaining issues:

 * It consistently fails to work with the aRts server under KDE. I get "Sound server
fatal error. CPU overload: aborting" and then ""artsmessage: unix_connect: can't
connect to server." 
 * The headphone jack is dead -- this is the greatest functional loss. The
microphone jack is working; I'm unsure about the quality.
 * It's slightly erratic for some reason -- I haven't found a pattern to it. The
codec itself is very occasionally detected as AC97 Modem codec, id: ADS114, or as
AC97 Audio codec, id: ADA68.

I discovered I could use mp3blaster to increase the volume by pressing t for mixer 
and chosing PCM; this is then available in X also. I assume there's some more 
elegant way to do this -- some audio control tool? Software volume control in xmms 
works when I use the OSS driver.

Cheers,
Peter




Quoting Alan Cox <alan@redhat.com>:

> > I've downloaded the latest driver and am running 2.4.20 (yea!) -- the
> trident.c here
> > is actually more recent than 2.5.55. It now loads fast and with no protest
> from
> > ac97_codec, which has a new ID (ADS114). However, there's still not a peep
> (I try
> > cat test.mp3 > /dev/dsp) -- and when KDE Control Center tries to restart
> the arts
> > sound server, it alarmingly fails on "CPU overload" or just freezes the
> whole
> > system. Is there anything I can do to get more information about what is
> not
> > happening?
>
> No but the info is very useful. The key change involving ac97 is that the
> new code in 2.4.x waits much longer for the codec reset to finish. I'm not
> sure where the audio has gone however 8(
>
>


