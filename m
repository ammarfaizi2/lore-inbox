Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUASToT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUASToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 14:44:19 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:22508 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262033AbUASToS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 14:44:18 -0500
Date: Mon, 19 Jan 2004 20:42:55 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
In-Reply-To: <1074532714.16759.4.camel@midux>
Message-ID: <Pine.LNX.4.58.0401192036070.3707@pnote.perex-int.cz>
References: <1074532714.16759.4.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Markus Hästbacka wrote:

> Hello list,
> I wonder what's the difference with ALSA and OSS. I have tried both,
> someone may say that ALSA is much better than OSS, but with my
> experience with ALSA I wouldn't say that, I would probably say it should
> be removed from the kernel totally.

It seems that you don't understand our goals. Please, look to our web
pages - http://www.alsa-project.org. If you use audio devices only for
consumer use, you probably don't notice anything special.

> So, what are the reasons for ALSA to become "default" in 2.6?
> I know it gives somekind of nice features, but ALSA didn't let me to
> open two sound sources (like XMMS and Quake3) at the same time, so I
> guess it is not really done yet, or is it?

We don't do this in kernel. We implemented the direct stream mixing in our 
library (userspace). If your applications already uses ALSA APIs or if you 
redirect the OSS ioctls to ALSA library (our aoss library), you can enjoy 
multiple sounds.

Of course, using hardware which can do the hardware mixing is still 
better. It's the same difference like between sw 3D rendering and hw 3D 
rendering.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
