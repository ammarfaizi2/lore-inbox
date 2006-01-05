Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWAEPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWAEPaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAEPaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:30:10 -0500
Received: from gate.perex.cz ([85.132.177.35]:54962 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932077AbWAEPaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:30:08 -0500
Date: Thu, 5 Jan 2006 16:30:06 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olivier Galibert <galibert@pobox.com>,
       Heikki Orsila <shd@modeemi.cs.tut.fi>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <43BD3AAC.9000104@gmail.com>
Message-ID: <Pine.LNX.4.61.0601051627590.10350@tm8103.perex-int.cz>
References: <20060105140155.GC757@jolt.modeemi.cs.tut.fi>
 <Pine.LNX.4.61.0601051518370.10350@tm8103.perex-int.cz>
 <20060105145101.GB28611@dspnet.fr.eu.org> <43BD3AAC.9000104@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Alexander E. Patrakov wrote:

> Olivier Galibert wrote:
> 
> > Make simple things simple, guys.
> 
> Sorry for hijacking the thread, but it is very true. ALSA is just too flexible
> so that the ALSA equivalent (if it indeed exists) of
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=339951 cannot be fixed. OSS
> allows specification of device name, and one can set up udev rules so that
> e.g. /dev/dsp-creative it is always a symlink to a SB PCI sound card and
> /dev/dsp-fortemedia is for FM801. Then one can tell xine to play sound through
> /dev/dsp-fortemedia. ALSA accepts only numbers in its plughw:x,y,z notation,
> and applications are unfixable when kernel device numbers become random.

It's not true. You can also use plughw:CARDID,0 or so notation. 
Identification of cards are available via control interface or look 
to /proc/asound/cards file. The card ID string can be set via
a module option. Also you can fix the card index numbers with
a module option.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
