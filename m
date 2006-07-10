Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWGJXv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWGJXv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWGJXv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:51:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36820 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965069AbWGJXv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:51:56 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
From: Lee Revell <rlrevell@joe-job.com>
To: Adam =?iso-8859-2?Q?Tla=B3ka?= <atlka@pg.gda.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz, alan@lxorguk.ukuu.org.uk
In-Reply-To: <44B2E4FF.9000502@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de>
	 <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	 <20060710132810.551a4a8d.atlka@pg.gda.pl>
	 <1152571717.19047.36.camel@mindpipe>  <44B2E4FF.9000502@pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-2
Date: Mon, 10 Jul 2006 19:51:44 -0400
Message-Id: <1152575505.19047.52.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 01:38 +0200, Adam Tla³ka wrote:
> U¿ytkownik Lee Revell napisa³:
> > On Mon, 2006-07-10 at 13:28 +0200, Adam Tla³ka wrote:
> >> >From my point of view ALSA has many advantages if you want to dig in
> >> the card driver buffers/period etc. settings but lacks ease of use and
> >> some of simple in theory functionality is a pain - device enumeration
> >> or switching output mode/device without restarting apps or rewritting
> >> them so they have special function for that purpose.
> >>
> > 
> > Does any available sound driver interface allow switching output devices
> > with no help from the app and without having to restart playback?  OSS
> > does not, and every Windows app I've used has a configuration option to
> > set the sound device, and you must stop and start playback for it to
> > take effect.
> 
> Sorry but is a Windows solution the best on the whole world?
> Is there any problem to imagine an abstract sound device which virtually 
> always works but uses real device chosen by user, network redirection or 
>   emulating work and we have some control panel/app which can control 
> connections/plugins/redirections etc. (also this can be done by some 
> kind of daemon responding to hw change events)?
> Do we really need to program every sound app to have device setting code?
> 

The problem is you trade ease of development for performance, penalizing
the users to save developer time.  Your proposals would require every
app to go through a software buffering layer.

Of course, you're free to develop a system like this.

> >> esd, arts, jackd, polypd and other prove that ALSA is not enough
> >> and its functionality is far from perfect.
> >>
> > 
> > esd and artsd are no longer needed since ALSA began to enable software
> > mixing by default in release 1.0.9.
>  >
> 
> So why they are still exist in so many Linux distributions?
> 

Backwards compatibility, bugs still being worked out, waiting for
upstream to catch up, etc.  Same reason that distros never have the very
latest version of every app.

> > As for jackd and other apps that
> > provide additional functionality - no one ever claimed ALSA would handle
> > every audio related function imaginable.  It's just a low level HAL.
> 
> Format changing, resampling, mixing and supporting additional plugins
> does not seems to be just low level HAL for hw device. It creates some 
> kind of virtual functionality which means more then this provided by 
> hardware device itself.

OK, but my point is that it does not make sense to put every imaginable
audio feature in ALSA.

Lee

