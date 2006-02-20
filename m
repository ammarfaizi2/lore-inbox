Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWBTA1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWBTA1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBTA1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:27:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16063 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751125AbWBTA1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:27:08 -0500
Date: Mon, 20 Feb 2006 01:26:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220002628.GG15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz> <1140393222.2733.438.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140393222.2733.438.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one
> > > > that uses 
> > > > emu10k1). 
> > > 
> > > It's a specific change to the SBLive! that did not affect the Audigy
> > > that causes alsa-lib 1.0.10+ to be required on 2.6.14 and up.  These
> > > types of incompatible changes should be rare.
> > 
> > Do you have that patch somewhere handy?
> > 
> 
> Attached

Thanks, I tried that. No change, AFAICT.

> > How do I tell alsa-lib version?
> > 
> 
> Check your distro's package manager.

Heh..

root@hobit:~# apt-cache show libasound1
Package: libasound1
Status: install ok installed
Priority: optional
Section: libs
Installed-Size: 148
Maintainer: Masato Taruishi <taru@debian.org>
Source: alsa-lib-0.5
Version: 0.5.10b-1
~~~~~~~~~~~~~~~~~~
:-(

...but if I launch plain old aumix, I should be able to unmute it and
use normally... and that is not the case :-(.

> > > It was a necessary precursor to fixing the well known "master volume
> > > only controls front speakers" bug.
> > 
> > 								Pavel

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> Fix the confliction of 'Front' controls on models with STAC9758 codec.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
> 
>  sound/pci/emu10k1/emumixer.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> Index: linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
> ===================================================================
> --- linux-2.6.15.3.orig/sound/pci/emu10k1/emumixer.c
> +++ linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
> @@ -750,6 +750,8 @@ int __devinit snd_emu10k1_mixer(emu10k1_
>  		"Master Mono Playback Volume",
>  		"PCM Out Path & Mute",
>  		"Mono Output Select",
> +		"Front Playback Switch",
> +		"Front Playback Volume",
>  		"Surround Playback Switch",
>  		"Surround Playback Volume",
>  		"Center Playback Switch",
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
