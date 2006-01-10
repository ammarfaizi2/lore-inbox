Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWAJORY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWAJORY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWAJORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:17:24 -0500
Received: from gate.perex.cz ([85.132.177.35]:51349 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932148AbWAJORX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:17:23 -0500
Date: Tue, 10 Jan 2006 15:17:21 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Hannu Savolainen <hannu@opensound.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601101550390.24146@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.61.0601101508560.10330@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601101144130.10330@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0601101550390.24146@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Hannu Savolainen wrote:

> On Tue, 10 Jan 2006, Jaroslav Kysela wrote:
> 
> > > 
> > > Then you can include a libOSSlib.o library in ALSA with all the OSS 
> > > emulation stuf inside.
> > 
> > You should do the clear statement that the direct using of syscalls is not 
> > recommented for application developers. Unfortunately at this time, I 
> > admit, it would be very difficult to change the existing applications.

> Sorry. That breaks backward compatibility with systems that don't have 
> libOSSlib (all current and past Linux distros, all BSD variants, 
> everything but systems with our official OSS package installed). Such 
> statement can be added in 2010 but provided that all Linux distros and 
> other environments having OSS compatible implementations add the osslib_* 
> routines within this year.

I meant that you can originate to move the OSS entry point to somewhere 
else (library) and try to persuade developers to use library than direct 
calls.

Of course, we cannot change current applications, but we can start the 
movement now. I just ask you to do it now. Nothing else. It will be a slow 
process but it should be started now.

Also, I don't think that it will break something. The application 
developers can use your code in their applications directly when the 
distribution does not have the OSS access library package.

Note that your words clearly states your attitude to change something.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
