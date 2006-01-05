Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWAESrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWAESrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWAESrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:47:11 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:48241 "HELO
	matthew.ogrody.nsm.pl") by vger.kernel.org with SMTP
	id S1751885AbWAESrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:47:10 -0500
Date: Thu, 5 Jan 2006 19:47:03 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <tapas@affenbande.org>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
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
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060105184703.GB4010@irc.pl>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Florian Schmidt <tapas@affenbande.org>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	perex@suse.cz, alsa-devel@alsa-project.org,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <20060104113726.3bd7a649@mango.fruits.de> <1136445395.24475.17.camel@mindpipe> <20060105124317.2d12a85c@mango.fruits.de> <1136486180.31583.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136486180.31583.29.camel@mindpipe>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:36:20PM -0500, Lee Revell wrote:
> On Thu, 2006-01-05 at 12:43 +0100, Florian Schmidt wrote:
> > On Thu, 05 Jan 2006 02:16:35 -0500
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > On Wed, 2006-01-04 at 11:37 +0100, tapas wrote:
> > > > ALSA's kernel level OSS emulation (as opposed to aoss) cannot provide
> > > > software mixing. As aoss cannot provide OSS emulation to all OSS apps
> > > 
> > > Why not?
> > 
> > I did write it out before. aoss is a LD_PRELOAD hack. Apps/libs that
> > resolve the system call symbols at build time cannot be made to use
> > these calls from a different lib (which is what LD_PRELOAD tries to do).
> > A famous example is libc for which a workaround was added (as libc
> > offers its own mechanism to intercept fopen() et al.). Others can lurk
> > in the background, too. It would even be trivial to write an app that
> > aoss will not work with - ever (unless the code be modified - which is
> > not an option for closed source apps).
> > 
> > It simply cannot ever work with _all_ apps (as opposed to kernel level
> > OSS emu  which can be made to work with _all_ apps (at least in
> > principle)).
> > 
> 
> OK so you can contrive an example.  Have we ever seen a real world app
> where aoss can't work?

  Skype. Earlier Quake 3 Arena (now Q3A is open source with SDL sound,
so it had native ALSA).
  They're more widely used that musical software for which ALSA seem to
be written. People needing <1ms latency are "obscure corner cases" in
real world.

-- 
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

