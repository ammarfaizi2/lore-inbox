Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWHIVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWHIVei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHIVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:34:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36276 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751387AbWHIVeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:34:37 -0400
Subject: Re: ALSA problems with 2.6.18-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <200608092222.05993.s0348365@sms.ed.ac.uk>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <200608091651.28077.gene.heskett@verizon.net>
	 <1155157036.26338.200.camel@mindpipe>
	 <200608092222.05993.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:34:37 -0400
Message-Id: <1155159278.26338.208.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 22:22 +0100, Alistair John Strachan wrote:
> On Wednesday 09 August 2006 21:57, Lee Revell wrote:
> > On Wed, 2006-08-09 at 16:51 -0400, Gene Heskett wrote:
> [snip]
> > > I already have the 'alsactl restore' in my rc.local.  Would there be any
> > > harm in just adding the -F to that invocation, or will that just restore
> > > it to a 'default' condition always.  Seems like it would, canceling
> > > anything you have done & then did an 'alsactl store' to save..
> >
> > That's what I was suggesting - just add -F to the alsactl restore in
> > your init script.  It won't restore it to a default state - the only
> > difference is that it will do a better job restoring your mixer state if
> > new controls are added by a driver update.
> >
> > alsactl --help:
> >
> >   -F,--force      try to restore the matching controls as much as
> > possible
> 
> I assume there are drawbacks to such an option, since whatever method is used 
> to "force" the control may make a mistake if similarly named controls are 
> renamed.
> 
> Personally, I think the correct approach would be to have more sensible 
> default values. Having the External Amplifier default off when it cripples 
> analogue output on emu10k1, and has no effect on digital output, seems rather 
> weird.

It's impossible to predict the effect of some mixer controls across the
wide range of hardware that ALSA supports.  What makes sound work on one
machine is likely to break it on another.

>  Also, I never really understood the rationale for the "all zeros" 
> mixer default. Why not 50%?
> 

This is policy and policy belongs in userspace.  Distros are free to
ship with any default mixer settings they choose.

Lee

