Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVL3TcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVL3TcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVL3TcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:32:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17799 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751299AbVL3TcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:32:01 -0500
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
In-Reply-To: <20051229132355.GA3811@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051222011320.GL3917@stusta.de> <20051222071557.GA17346@suse.de>
	 <s5hpsnpxrqw.wl%tiwai@suse.de>  <20051229132355.GA3811@stusta.de>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 14:31:58 -0500
Message-Id: <1135971119.31111.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 14:23 +0100, Adrian Bunk wrote:
> On Thu, Dec 22, 2005 at 01:04:23PM +0100, Takashi Iwai wrote:
> > At Wed, 21 Dec 2005 23:15:57 -0800,
> > Greg KH wrote:
> > > 
> > > On Thu, Dec 22, 2005 at 02:13:20AM +0100, Adrian Bunk wrote:
> > > > The following bug in the kernel Bugzilla contains a regressions in 
> > > > 2.6.15-rc without a patch:
> > > > - #5760 No sound with snd_intel8x0 & ALi M5455 chipset
> > > >         (kobject_register failed)
> > > 
> > > We put code in the kobjet to report when callers fail, due to problems
> > > in them, and the kobject code is blamed...
> > > 
> > > Looks like a sound driver issue, nothing has changed in the kobject
> > > code.
> > 
> > But there is no relevant change in sound stuff between 2.6.15-rc4 and
> > rc6 (except for minor fix of OSS drivers).  If it really worked with
> > 2.6.15-rc4, something else got broken.
> 
> I don't know whether this is related to the problem, but the code giving 
> the "AC'97 1 does not respond - RESET" warning that is present in both 
> the working and the non-working cases for the submitter looks a bit 
> fragile.
> 
> > Takashi

Two more post 2.6.14 ALSA regressions that IMHO need to be fixed for
2.6.15:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585
http://music.columbia.edu/pipermail/linux-audio-dev/2005-December/014269.html

Lee

