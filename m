Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWADLfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWADLfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWADLfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:35:32 -0500
Received: from gate.perex.cz ([85.132.177.35]:16802 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751729AbWADLfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:35:31 -0500
Date: Wed, 4 Jan 2006 12:35:25 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, kloczek@rudy.mif.pg.gda.pl,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060104030034.6b780485.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Pete Zaitcev wrote:

> On Wed, 4 Jan 2006 09:37:55 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> 
> > > 2) ALSA API is to complicated: most applications opens single sound
> > >    stream.
> > 
> > FUD and nonsense. []
> > http://devzero.co.uk/~alistair/alsa/
> 
> That's the kicker, isn't it? Once you get used to it, it's a workable
> API, if kinky and verbose. I have a real life example, too:
>  http://people.redhat.com/zaitcev/linux/mpg123-0.59r-p3.diff
> But arriving on the solution costed a lot of torn hair. Look at this
> bald head here! And who is going to pay my medical bills when ALSA
> causes me ulcers, Jaroslav?

Well, the ALSA primary goal is to be the complete HAL not hidding the 
extra hardware capabilities to applications. So API might look a bit 
complicated for the first glance, but the ALSA interface code for simple 
applications is not so big, isn't?

Also, note that app developers are not forced to use ALSA directly - there 
is a lot of "portable" sound API libraries having an ALSA backend doing
this job quite effectively. We can add a simple (like OSS) API layer 
into alsa-lib, but I'm not sure, if it's worth to do it. Perhaps, adding
some support functions for the easy PCM device initialization might be
a good idea.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
