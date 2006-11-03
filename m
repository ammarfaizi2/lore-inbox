Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753174AbWKCHI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbWKCHI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 02:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbWKCHI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 02:08:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:53674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1753174AbWKCHIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 02:08:25 -0500
Date: Thu, 2 Nov 2006 23:08:19 -0800
From: Greg KH <greg@kroah.com>
To: Damien Wyart <damien.wyart@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-ID: <20061103070819.GB2448@kroah.com>
References: <20061102102607.GA2176@localhost.localdomain> <20061102192607.GA13635@kroah.com> <878xitpkvy.fsf@brouette.noos.fr> <20061102222242.GA17744@kroah.com> <87lkmtf2bu.fsf@brouette.noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lkmtf2bu.fsf@brouette.noos.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 07:53:41AM +0100, Damien Wyart wrote:
> > > > Can you send me the output of 'ls /sys/class/sound/' with the
> > > > 2.6.19-rc4 (or any other non-mm) kernel?
> 
> > > With 2.6.19-rc4-mm2, this gives:
> > > admmidi  amidi  card0      dmmidi  hwC0D0  midi      midiC0D1  mixer    pcmC0D0p  pcmC0D2c  pcmC0D3p  sequencer   timer
> > > adsp     audio  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq       sequencer2
> 
> > > While Vanilla 2.6.19-rc4 leads to:
> > > admmidi  amidi  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq        sequencer2
> > > adsp     audio  dmmidi     hwC0D0  midi    midiC0D1  mixer     pcmC0D0p pcmC0D2c  pcmC0D3p  sequencer  timer
> 
> > > Seems there is an additional 'card0' entry in the first case.
> 
> * Greg KH <greg@kroah.com> [061102 23:22]:
> > That should be a symlink right?
> 
> The corresponding ls -l entry reads:
> lrwxrwxrwx 1 root root 0 Nov  3  2006 card0 -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:00.0/card0

That looks good.

And the other files in that directory are also symlinks pointing to one
directory below the card0 device (with the exception of the timer file),
right?

> > Well it will be if you have CONFIG_SYSFS_DEPRECATED disabled. What is
> > the setting of that config option?
> 
> I have:
> # CONFIG_SYSFS_DEPRECATED is not set

Ok.  That too looks good.

> I attach the full .config in case it is useful (had not sent it at
> first with the report).

Ok, I'm stumped.  Takashi, any ideas?

thanks,

greg k-h
