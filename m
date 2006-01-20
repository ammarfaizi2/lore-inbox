Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWATRlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWATRlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWATRlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:41:13 -0500
Received: from arkady.gaya.sk ([62.168.75.2]:22998 "EHLO arkady.gaya.sk")
	by vger.kernel.org with ESMTP id S1751105AbWATRlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:41:13 -0500
From: Peter Zubaj <pzad@pobox.sk>
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 18:44:29 +0100
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       perex@suse.cz
References: <20060119174600.GT19398@stusta.de> <s5hmzhr7xsr.wl%tiwai@suse.de> <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201844.29873.pzad@pobox.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 January 2006 17:30, Jan Engelhardt wrote:
> >> >If I understand alsa - oss emulation correctly, I think, this will be
> >> > not fixed soon (my opinion - never). This is too much work for too
> >> > little gain.
> >>
> >> On that way, I'd like to inquiry something:
> >> I have a card that works with the snd-cs46xx module.
> >> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the
> >> other two must be sent to /dev/adsp. Is this intended? Would not it be
> >> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
> >
> >This is exactly like the case of emu10k1.  The chip supports only
> >2-channel stereo streams.  If you need a 4-channel interleaved stream,
> >you have to merge the data in two individual streams to a single
> >4-channel stream on software.  Currently, this isn't handled in ALSA
> >kernel-space OSS emulation.
>
> Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
> is The Right Thing?

This will work for your card, but not for emu10k1.

Peter Zubaj
