Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDRDZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 23:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTDRDZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 23:25:05 -0400
Received: from dnvrdslgw14poolC198.dnvr.uswest.net ([63.228.86.198]:42335 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S262834AbTDRDZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 23:25:04 -0400
Date: Thu, 17 Apr 2003 21:37:13 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ac97, alc101+kt8235 sound (2.4.21-pre7-ac1)
In-Reply-To: <1050406611.27745.34.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304172107360.10001-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that the VT8235 has some issues with ac97 recording.  Using aumix,
and setting the input to line-in, cat /dev/dsp returns the same byte over
and over again, as if there is no signal.  Dumping this file and dumping
back to /dev/dsp confirms the silence - no sound got record.  Messing
around with the mixer doesn't appear to do much.  The mixer subsystem, I
can control the volume of line-in and line-out, and hear the volume going
up and down.  I also tried Windows, seems it works fine in Windows.

I tried the same command sequence on my SiS735 (i810-compatible) AC97
machine and the results differ (it works :-)  So it seems that there's
something that's wrong with the kt8235 side of things?

Playback works fine.  Just cannot record.  Is the kt8235 driver not quite
primetime yet?

Thanks,

-bc

On 15 Apr 2003, Alan Cox wrote:

> Date: 15 Apr 2003 12:36:51 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Benson Chow <blc+lkml@q.dyndns.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: ac97, alc101+kt8235 sound
>
> On Maw, 2003-04-15 at 12:49, Benson Chow wrote:
> > hoping that these via chips were pretty close.  Unfortunately no, it
> > still doesn't work.  It did, however, find the AC97 codec fine (I added
> > some printk's), but no sound is produced.  Any ideas on how to get this
> > vt8235-based motherboard sound working?  (and ALSA-0.9.2 seems to do
> > nothing but segfault it seems.)
>
> See 2.4.21pre - that has the driver for VIA8233/5
>

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.


