Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJAHCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJAHCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:02:31 -0400
Received: from gate.perex.cz ([194.212.165.105]:1167 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262063AbTJAHC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:02:29 -0400
Date: Wed, 1 Oct 2003 09:01:16 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Joshua Kwan <joshk@triplehelix.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA PATCH] OSS emulation fixes
In-Reply-To: <20030930233654.GC10262@triplehelix.org>
Message-ID: <Pine.LNX.4.53.0310010859350.13267@pnote.perex-int.cz>
References: <Pine.LNX.4.53.0309301247030.1362@pnote.perex-int.cz>
 <20030930233654.GC10262@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, Joshua Kwan wrote:

> Hi Jaroslav,
>
> On Tue, Sep 30, 2003 at 12:51:52PM +0200, Jaroslav Kysela wrote:
> > The pull command will update the following files:
> >
> >  include/sound/pcm_oss.h      |    1
> >  include/sound/rawmidi.h      |    1
> ...
>
> In 2.6.0-test6-mm1 with OSS emulation I encountered a problem where xine
> would use the sound card in OSS mode and no other application would be
> able to use it after that until I rebooted. Do any of these fixes
> address this problem?

Yes, it will fix oops when an application releases the OSS emulation
device.

> By the way - something you folks did during -test5 improved the quality
> of snd-intel8x0 by leaps and bounds. It used to crackle a lot at certain
> frequencies and works great now. :)

Yes, the method to obtain the current position in the DMA buffer was
changed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
