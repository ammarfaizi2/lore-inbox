Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUIVHzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUIVHzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUIVHzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:55:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:26358 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261610AbUIVHy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:54:57 -0400
Date: Wed, 22 Sep 2004 09:54:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Lenz <lenz@cs.wisc.edu>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new class for led devices
In-Reply-To: <1095829641l.11731l.0l@hydra>
Message-ID: <Pine.GSO.4.61.0409220953390.6324@waterleaf.sonytel.be>
References: <1095829641l.11731l.0l@hydra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, John Lenz wrote:
> This is an attempt to provide an alternative to the current arm specific led
> interface that is generic for all arches and uses the "one value, one file"
> idea of sysfs.
> 
> I removed the function attribute that was in the previous patch, and added the
> ability for userspace to control the timer on each led individually.
> Userspace can also set the delay in milliseconds for the blink.

(damned, non-inlined patch)

| - heartbeat: a read/write attribute that controls the heartbeat of this
|   led.  If heartbeat=0, then this led is controlled by userspace.
|   Otherwise, heartbeat gives the time in milliseconds to delay between
|   light changes.

That's not the real heartbeat! The real one says thumb-thumb-pause, and goes
faster if the load average increases :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
