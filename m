Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULTQgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULTQgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULTQgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:36:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:63911 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261564AbULTQgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:36:53 -0500
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hr7lluei7.wl@alsa2.suse.de>
References: <1103389648.5967.7.camel@gaston>
	 <1103391238.5775.0.camel@gaston>  <s5hr7lluei7.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 17:36:36 +0100
Message-Id: <1103560596.9065.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 17:21 +0100, Takashi Iwai wrote:
> At Sat, 18 Dec 2004 18:33:58 +0100,
> Benjamin Herrenschmidt wrote:
> > 
> > On Sat, 2004-12-18 at 18:07 +0100, Benjamin Herrenschmidt wrote:
> > > Hi Takashi !
> > > 
> > > I get that regulary with latest kernel when using Alsa. Can't tell if it's new
> > > as I used dmasound so far, just wanted to give Alsa a try...
> > 
> > It seems to be related to oss emulation I'd say ... it's triggered by
> > gtkpbbuttons volume control keys, which will open/ioctl/write/close the
> > device very quicky (changing volume & outputing a beep)
> 
> So, it's not reproducible when you do playback normally?
> Can you get /proc/asound/card0/pcm0p/sub0/hw_params during playback?

No, it's not something that happens during normal playback, but
occasionally when tweaking the volume ... I suspect a fast
open/ioctl/close sequence or something like that... weird.

> > Maybe a race ? This is a laptop, so UP, no PREEMPT.
> 
> Well, the volume and PCM shouldn't be racy.  I'd first suspect another
> bug in PCM OSS emulation code...
> 
> Could you compile with CONFIG_SND_DEBUG=y and see whether it catches
> anything?

Ok.

Ben.


