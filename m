Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCOLcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCOLcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVCOLcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:32:47 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:30155 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261160AbVCOLco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:32:44 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Jan De Luyck <lkml@kcore.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
In-Reply-To: <1110874241.32535.44.camel@sli10-desk.sh.intel.com>
References: <20050314080029.GF22635@elf.ucw.cz>
	 <1110874241.32535.44.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1110886444.6454.121.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 15 Mar 2005 22:34:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-03-15 at 19:10, Li Shaohua wrote:
> Hi,
> On Mon, 2005-03-14 at 16:00, Pavel Machek wrote:
> > Hi!
> > 
> > >   * MySQL (hinders the actual suspension process and kicks the pc
> > back to 
> > >     where it was)
> > 
> > Try this patch...
> >                                                                 Pavel
> > 
> > --- clean/kernel/signal.c       2005-02-03 22:27:26.000000000 +0100
> > +++ linux/kernel/signal.c       2005-02-03 22:28:19.000000000 +0100
> > @@ -2222,6 +2222,7 @@
> >                         ret = -EINTR;
> >         }
> >  
> > +       try_to_freeze(1);
> >         return ret;
> >  }
> I also encounter a similar issue. syslogd can't be stopped. It's waiting
> for kjournald to flush some works but kjournald is stopped first. Looks
> like the kernel thread should be stopped later than user thread just
> like Nigel's suspend2 patch does.

Pavel, do you have any kernel/power/process.c changes in? If not, I'll
submit those refrigerator changes.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

