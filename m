Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTIJSSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbTIJSSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:18:25 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:48076 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265435AbTIJSSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:18:23 -0400
Subject: Re: Audio skipping with alsa
From: Chris Meadors <clubneon@hereintown.net>
To: Russ Garrett <rg@tcslon.com>
Cc: root@chaos.analogic.com, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <1063216041.1208.10.camel@russell>
References: <1063116861.852.50.camel@russell> <s5hk78gvkt7.wl@alsa2.suse.de>
	 <Pine.LNX.4.53.0309101536080.1411@pnote.perex-int.cz>
	 <s5hhe3kvjtc.wl@alsa2.suse.de>  <Pine.LNX.4.53.0309101037120.12986@chaos>
	 <1063216041.1208.10.camel@russell>
Content-Type: text/plain
Message-Id: <1063217788.2251.51.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Sep 2003 14:16:28 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19x9Xl-0004qv-MC*blhdpOEpRLI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 13:47, Russ Garrett wrote:
> It's ALSA, so it isn't in the 2.4 tree - it's in sound/pci/ice1712/ in
> 2.6. And FWIW, this happens continuously, not just in the 25 seconds (or
> whatever) after playback starts.

I have a Envy24 ICE1712 based card also.  I have noticed the same
thing.  I would say in the first 25 seconds I can't do anything with my
machine without getting a skip.  But after 25 seconds, it is pretty
good.  Pushing my machine hard, lots of disk or X activity can induce
small skips after that 25 seconds (I've been meaning to try the new
scheduler patches).

I'll agree that larger buffers are not the answer.  I sometimes mess
with live audio effects.  That is recording some audio, processing it in
some way, and then playing it back.  If the buffer is too large, a
noticeable delay would be introduced.  Takashi and Jaroslav I'm pretty
sure know the problem this causes with musicians, who need to hear what
they played or sang in a very short period of time, or it messes with
the brain.  I'm just not sure all the kernel developers are also aware
of this effect.  It is more than just not having to wait a minute to
hear the effects of an EQ change.

-- 
Chris

