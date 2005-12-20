Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVLTVKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVLTVKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVLTVKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:10:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932077AbVLTVKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:10:36 -0500
Date: Tue, 20 Dec 2005 13:06:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Courtier-Dutton <James@superbug.co.uk>
cc: Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <43A86DCD.8010400@superbug.co.uk>
Message-ID: <Pine.LNX.4.64.0512201303580.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, James Courtier-Dutton wrote:

> Linus Torvalds wrote:
> > 
> > On Tue, 20 Dec 2005, Adrian Bunk wrote:
> > 
> > > But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no
> > > longer working.
> > 
> > 
> > Ahh. I assume it's the sequencer init etc that is missing.
> > 
> > Maybe we'll just have to do the late_init thing for at least the 2.6.15
> > timeframe.
> 
> But that's not really a useable fix. The problem is with almost all ALSA sound
> cards.

Right. Which is why the _correct_ fix is certainly to just initialize the 
core functionality early.

So the fix is certainly _usable_ (and simple, and guaranteed to not break 
anything, which is why it's fine 2.6.15 material), but I certainly agree 
that a much better fix would be for a sound core person to walk through 
the subsystem initializers, and just mark _those_ early instead.

Hint hint ;)

		Linus
