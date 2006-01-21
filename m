Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWAUA5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWAUA5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAUA5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:57:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26899 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932268AbWAUA53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:57:29 -0500
Date: Sat, 21 Jan 2006 01:57:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060121005728.GO31803@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain> <20060119224222.GW21663@redhat.com> <1137711088.3241.9.camel@mindpipe> <1137719627.8471.89.camel@localhost.localdomain> <20060120013402.GF3798@redhat.com> <s5hacdr9mdi.wl%tiwai@suse.de> <1137803349.3241.21.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137803349.3241.21.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 07:29:09PM -0500, Lee Revell wrote:
> On Fri, 2006-01-20 at 12:20 +0100, Takashi Iwai wrote:
> > At Thu, 19 Jan 2006 20:34:02 -0500,
> > Dave Jones wrote:
> > > 
> > > On Fri, Jan 20, 2006 at 01:13:47AM +0000, Alan Cox wrote:
> > >  > On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
> > >  > > The status is we need someone who has the hardware who can add printk's
> > >  > > to the driver to identify what triggers the hang.  It should not be
> > >  > > hard, the OSS driver reportedly works.
> > >  > > 
> > >  > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
> > >  > > 
> > >  > > The bug has been in FEEDBACK state for a long time.
> > >  > 
> > >  > 99.9% of users don't ever look in ALSA bugzilla. 
> > >  > 
> > >  > A dig shows
> > >  > 
> > >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
> > >  > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221
> > > 
> > > Lee, if you can point me at a patch with debugging printk's I'm
> > > happy to throw that into the next Fedora test update for the
> > > users in the latter bug to test. (The first one seemed to go AWOL)
> > 
> > The bug for Latitude CSx should have been fixed by the following
> > commit:
> > 
> > 	commit 47530cf44cb5f3945ed04a5ae65d06bf423cd97b
> > 	Author: John W. Linville <linville@tuxdriver.com>
> > 	Date:   Wed Oct 19 16:03:10 2005 +0200
> > 
> > 	    [ALSA] nm256: reset workaround for Latitude CSx
> > 
> > This might not conver all Dell models.  In such a case, try
> > reset_workaround2=1.  See the section of nm256 in
> > ALSA-Configuration.txt for details.
> 
> OK I will update the ALSA bug report with this info.  IIRC at least one
> user already reported that the above commit does not fix the hangs.

The bug reporter reported this in the last comment of the bug (1.0.10rc3 
already included the mentioned fix).

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

