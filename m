Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWBTQcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWBTQcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWBTQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63116 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161013AbWBTQcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:04 -0500
Date: Mon, 20 Feb 2006 12:41:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220114129.GA16165@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com> <7c3341450602190318o1c60e9b5w@mail.gmail.com> <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe> <20060219214934.GO15311@elf.ucw.cz> <1140386075.2733.399.camel@mindpipe> <20060219222533.GB15608@elf.ucw.cz> <s5hzmkm1dtl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzmkm1dtl.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ouch and that device should be still listed in devices.txt, no?
> 
> The minor numbers can be assigned dyanmically if
> CONFIG_SND_DYNAMIC_MINORS is set, so it may be even confusing to list
> up there as if static only.

Well, you should list them there, so they are properly allocated to
you...  Or just list the numbers for !SND_DYNAMIC_MINORS case, and add
a warning.

> > root@hobit:/dev/snd#  aplay
> > /usr/share/xemacs21/xemacs-packages/etc/sounds/hammer.wav
> > Playing WAVE
> > '/usr/share/xemacs21/xemacs-packages/etc/sounds/hammer.wav' : Unsigned
> > 8 bit, Rate 8000 Hz, Mono
> > root@hobit:/dev/snd#
> > 
> > Actually, in a quiet room I think I can hear *something*. Too faint to
> > recognize :-(.
> 
> If you hear something, it's definitely a mixer configuration problem,
> maybe screwed up by some reason.  In such a case, it's easier to
> re-initialize from the scratch:

It may me EMI or something like that. I can hear something but it is
so faint I'm not sure if I'm not hearing power drawn from CPU.

> Unload the module first, then remove /etc/asound.state (or whatever
> the distro uses) to prevent the automatic "alsactl restore".
> Reload the module, then unmute/adjust the volume "PCM" and "Master".
> The other volumes should have been initialized to be audible.

I do not think I have alsactl restore anywhere in the bootup
scripts. I'll play with that, and I'll also try OSS driver to see if
hardware still works properly.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
