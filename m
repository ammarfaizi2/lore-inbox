Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWBMSyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWBMSyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWBMSyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:54:24 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:53092 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964803AbWBMSyX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:54:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CT6q6cN/RarPQ0wYAbWYaHCooBbDsxziSB3UgNLCvNl1W9DpNQmvJ1zi56YcyEEIeveCNchixuD/q2F6teBMVXck8Vb3o/vnIc13xn59EFlJKnTC8fxvQjczAY/hsfVtk7Ac/Ze5rtjDNVuT1Bv3gDlHBbc7JK7TaEyvKZD+Go0=
Message-ID: <7c3341450602131054k71e3a8c4o@mail.gmail.com>
Date: Mon, 13 Feb 2006 18:54:22 +0000
From: Nick Warne <nick@linicks.net>
Reply-To: Nick Warne <nick@linicks.net>
To: ghrt <ghrt@dial.kappa.ro>
Subject: Re: Fw: PROBLEM: SB Live! 5.1 (emu10k1, rev. 0a) doesn't work with 2.6.15
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <s5h7j7z47q4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060213040900.1e360292.akpm@osdl.org>
	 <s5h7j7z47q4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i've compiled vanilla 2.6.15 and my sound card doesn't work anymore.
> > i can see it in kmix (and adjust the volumes, too), it appears in
> > dmesg (at ALSA devices), xmms & mplayer doesn't say anything about
> > errors, but it doesn't make any sound.
> > the onboard soundcard, via8233, works well with the same 2.6.15.
> > sb live! works well with 2.6.14.2 and previous.
> > i'm using an updated Slackware.
> >
> > if you have any questions i'll answer.
>
> First check /proc/asound/cards to see whether the emu10k1 model is
> detected properly.  If '[Unknown]' is shown, your model is not
> listed in the whitelist.
>
> There was a bug that the front control conflicts with ac97 and emu10k1
> dsp which was already fixed in the latest version (at least on
> 2.6.16-rc3).

For what it is worth, I had issues with my SB Live! but as this all
(appeared) to start when my CPU died and I had to reset BIOS or if I
did indeed move up to 2.6.15 at around the same time I can't remember
(2.6.15 release and CPU died all around same date) - refer to the
following:

http://lkml.org/lkml/2006/2/11/4

As stated the solution for me was to update alsa-utils and alsa-libs
which fixed the issues I was getting - I found that if one of the
'controls' (15, I think?) was invalid at boot, all the volume settings
in alsamixer got set to '0' (i.e. mute/turned off) - no sound.

Nick
