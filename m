Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWAUA3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWAUA3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWAUA3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:29:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:60354 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932299AbWAUA3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:29:14 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
In-Reply-To: <s5hacdr9mdi.wl%tiwai@suse.de>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com> <1137711088.3241.9.camel@mindpipe>
	 <1137719627.8471.89.camel@localhost.localdomain>
	 <20060120013402.GF3798@redhat.com>  <s5hacdr9mdi.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 19:29:09 -0500
Message-Id: <1137803349.3241.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 12:20 +0100, Takashi Iwai wrote:
> At Thu, 19 Jan 2006 20:34:02 -0500,
> Dave Jones wrote:
> > 
> > On Fri, Jan 20, 2006 at 01:13:47AM +0000, Alan Cox wrote:
> >  > On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
> >  > > The status is we need someone who has the hardware who can add printk's
> >  > > to the driver to identify what triggers the hang.  It should not be
> >  > > hard, the OSS driver reportedly works.
> >  > > 
> >  > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
> >  > > 
> >  > > The bug has been in FEEDBACK state for a long time.
> >  > 
> >  > 99.9% of users don't ever look in ALSA bugzilla. 
> >  > 
> >  > A dig shows
> >  > 
> >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
> >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221
> > 
> > Lee, if you can point me at a patch with debugging printk's I'm
> > happy to throw that into the next Fedora test update for the
> > users in the latter bug to test. (The first one seemed to go AWOL)
> 
> The bug for Latitude CSx should have been fixed by the following
> commit:
> 
> 	commit 47530cf44cb5f3945ed04a5ae65d06bf423cd97b
> 	Author: John W. Linville <linville@tuxdriver.com>
> 	Date:   Wed Oct 19 16:03:10 2005 +0200
> 
> 	    [ALSA] nm256: reset workaround for Latitude CSx
> 
> This might not conver all Dell models.  In such a case, try
> reset_workaround2=1.  See the section of nm256 in
> ALSA-Configuration.txt for details.

OK I will update the ALSA bug report with this info.  IIRC at least one
user already reported that the above commit does not fix the hangs.

Lee

