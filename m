Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWAEVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWAEVKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWAEVKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:10:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64969 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932207AbWAEVKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:10:07 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Edgar Toernig <froese@gmx.de>
Cc: Florian Schmidt <tapas@affenbande.org>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060105220537.1b90598d.froese@gmx.de>
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
	 <1136445063.24475.11.camel@mindpipe>
	 <20060105200911.5aa4e705.froese@gmx.de>
	 <1136489348.31583.47.camel@mindpipe> <1136492363.847.12.camel@mindpipe>
	 <20060105220537.1b90598d.froese@gmx.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 16:10:02 -0500
Message-Id: <1136495403.847.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 22:05 +0100, Edgar Toernig wrote:
> Lee Revell wrote:
> >
> > > > And btw, with 2.6.15 the usb-speakers only produce noise most of
> > > > the time.
> > > 
> > > Known regression, this is being worked on.  It was known and posted to
> > > LKML before the 2.6.15 release, unfortunately 2.6.15 was released with
> > > this bug anyway.
> > 
> > If you'd like to help debug this:
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585
> > 
> > There's a workaround patch available.  We still don't know the exact
> > nature of the bug.
> 
> Well, the problem I had was not exactly the same (I get loud noise, as
> if the samples are byte-swapped) but
> 
>    alsa-usbaudio-2.6.15-revert-008.patch
> 
> seems to fix that.  Thanks.
> 
> But now (alsa-1.0.9 userspace):
> 
>   alsaplayer -i text -d hw:0 ...    --> ok
>   alsaplayer -i text -d hw:1 ...    --> ok
>   alsaplayer -i text -d dmix:0 ...  --> ok
>   alsaplayer -i text -d dmix:1 ...  --> no error, no sound, just total
>                                         silence.  But the clock's running.
> 
> with 2.6.13 all 4 are ok.
> 
> Ciao, ET.
> 
> PS: Someone reported on bugzilla that his usb-audio is not always detected.
> Just for the record - happens here too, usually when cold-booting.
> 

OK.  This is getting a bit much for LKML, can you open a new bug and set
it related to #1585?

Lee

