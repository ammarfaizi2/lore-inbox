Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVCOMFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVCOMFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVCOMFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:05:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40160 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261180AbVCOMFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:05:17 -0500
Date: Tue, 15 Mar 2005 13:04:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Li Shaohua <shaohua.li@intel.com>, Jan De Luyck <lkml@kcore.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Message-ID: <20050315120448.GF1344@elf.ucw.cz>
References: <20050314080029.GF22635@elf.ucw.cz> <1110874241.32535.44.camel@sli10-desk.sh.intel.com> <1110886444.6454.121.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110886444.6454.121.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > >   * MySQL (hinders the actual suspension process and kicks the pc
> > > back to 
> > > >     where it was)
> > > 
> > > Try this patch...
> > >                                                                 Pavel
> > > 
> > > --- clean/kernel/signal.c       2005-02-03 22:27:26.000000000 +0100
> > > +++ linux/kernel/signal.c       2005-02-03 22:28:19.000000000 +0100
> > > @@ -2222,6 +2222,7 @@
> > >                         ret = -EINTR;
> > >         }
> > >  
> > > +       try_to_freeze(1);
> > >         return ret;
> > >  }
> > I also encounter a similar issue. syslogd can't be stopped. It's waiting
> > for kjournald to flush some works but kjournald is stopped first. Looks
> > like the kernel thread should be stopped later than user thread just
> > like Nigel's suspend2 patch does.
> 
> Pavel, do you have any kernel/power/process.c changes in? If not, I'll
> submit those refrigerator changes.

No, process.c was left unchanged for quite a long time.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
