Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWAESgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWAESgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWAESgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:36:25 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38586 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751880AbWAESgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:36:24 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <tapas@affenbande.org>
Cc: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060105124317.2d12a85c@mango.fruits.de>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
	 <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
	 <20060103231009.GI3831@stusta.de>
	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	 <20060104000344.GJ3831@stusta.de>
	 <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	 <20060104010123.GK3831@stusta.de>
	 <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	 <20060104113726.3bd7a649@mango.fruits.de>
	 <1136445395.24475.17.camel@mindpipe>
	 <20060105124317.2d12a85c@mango.fruits.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 13:36:20 -0500
Message-Id: <1136486180.31583.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 12:43 +0100, Florian Schmidt wrote:
> On Thu, 05 Jan 2006 02:16:35 -0500
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Wed, 2006-01-04 at 11:37 +0100, tapas wrote:
> > > ALSA's kernel level OSS emulation (as opposed to aoss) cannot provide
> > > software mixing. As aoss cannot provide OSS emulation to all OSS apps
> > 
> > Why not?
> 
> I did write it out before. aoss is a LD_PRELOAD hack. Apps/libs that
> resolve the system call symbols at build time cannot be made to use
> these calls from a different lib (which is what LD_PRELOAD tries to do).
> A famous example is libc for which a workaround was added (as libc
> offers its own mechanism to intercept fopen() et al.). Others can lurk
> in the background, too. It would even be trivial to write an app that
> aoss will not work with - ever (unless the code be modified - which is
> not an option for closed source apps).
> 
> It simply cannot ever work with _all_ apps (as opposed to kernel level
> OSS emu  which can be made to work with _all_ apps (at least in
> principle)).
> 

OK so you can contrive an example.  Have we ever seen a real world app
where aoss can't work?

> Errm, i'm actually wrong about that. Kernel level OSS emu sw mixing
> cannot work together with userspace ALSA sw mixing. I completely missed
> that point.
> 
> I still think, the easiest way would be to use FUSE as it gives the best
> of both worlds:

Yep, this does sound like a promising approach.  AFAIK it's never been
seriously explored as FUSE is so new.

Lee

