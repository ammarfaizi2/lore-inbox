Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTDWTHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDWTHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:07:37 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:13025 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264353AbTDWTHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:07:34 -0400
Date: Wed, 23 Apr 2003 15:05:45 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423190545.GY354@phunnypharm.org>
References: <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The problem you see with the irq disabling around kernel_thread() may
> > > not be there in -pre7, but that's only because the shared data with the
> > > thread was not protected from a race condition that causes an oops in
> > > some not-so-rare cases.
> >
> > I confirm that your patch at least solves the initialisation issues.
> > I'll test later with some ieee devices and I'll report back if I found
> > other issues.
> 
> Any news on that, Stelian ?
> 
> I guess Ben's mega patch (and yes, I also consider it a megapatch for
> -rc) has to be applied. I just mailed him asking about the possibility
> of getting only fixes in and not the cleanups, but I guess that might be a
> bit hard to do _today_. Right Ben ?

Yeah, it's pretty hard. I didn't do all these changes with the intent of
it being a 2.4.21 thing, but it definitely dragged on to the point where
I had no choice, and pulling the fixes out of the major work became too
much work.

> And about the sweet complaints about -pre timing, I will release -pre's
> each damn week for .22.

If you could just commit patches to the bk repo as you get them, instead
of holding them for a month and dumping them all in at once, it would be
easier to follow things. Instead, we got several huge lumps late in
2.4.21-pre's.

Wasn't my intent to bash you, but I will admit that 2.4.21 has been a
pain in my ass because of the cycle :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
