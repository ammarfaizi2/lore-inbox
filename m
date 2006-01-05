Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752070AbWAEHLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWAEHLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWAEHLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:11:09 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:46796 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752070AbWAEHLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:11:07 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <tapas@affenbande.org>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060104191750.798af1da@mango.fruits.de>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
	 <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
	 <20060103231009.GI3831@stusta.de>
	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	 <20060104000344.GJ3831@stusta.de>
	 <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	 <20060104010123.GK3831@stusta.de>
	 <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	 <20060104113726.3bd7a649@mango.fruits.de> <s5hsls398uv.wl%tiwai@suse.de>
	 <20060104191750.798af1da@mango.fruits.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 02:11:03 -0500
Message-Id: <1136445063.24475.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 19:17 +0100, Florian Schmidt wrote:
> On Wed, 04 Jan 2006 18:54:48 +0100
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > Note that as of OSS emulation, this is no longer true.  The OSS
> > devices are opened as "non-blocking" per default.  ALSA native devices
> > are opened as "blocking" just to keep the compatible behavior,
> > though.
> 
> Hi Takashi,
> 
> do you know of _any_ app relying on this behaviour? If not, make
> blocking open and blocking read/write different things (as they really
> are different things). Maybe create a /proc control, so users can revert
> to the olde behaviour if there really is any need.
> 
> I simply cannot imagine that any ALSA app relies on this weird
> behaviour. I only ever hear how it confuses people [Hang out a bit on
> #alsa on irc.freenode.org: "my alsa driver is broken as this and that
> app hangs!!!" - "no it's expected behaviour" - "WTF!!!?" ;) <- smiley].
> It is also still quite a common case i suppose as when an OSS app has a
> device open, the ALSA apps trying to open it in blocking mode will again
> hang. Or so i'd think. My soundcard is hw mixing capable (thank god ;)),
> so i don't really know, and it's been a while since i hang out regularly
> on that channel. If i talk out of my ass, let me know.

All of this was solved with the switch in ALSA 1.0.9 to use dmix by
default.  If it does not Just Work it's a bug and we need to hear about
it.

Lee

