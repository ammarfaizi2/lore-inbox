Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136581AbREAHJI>; Tue, 1 May 2001 03:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136582AbREAHI6>; Tue, 1 May 2001 03:08:58 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:7432 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S136581AbREAHIx>; Tue, 1 May 2001 03:08:53 -0400
Date: Tue, 1 May 2001 08:08:50 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: David Lang <david.lang@digitalinsight.com>,
        valery <valery.brasseur@atosorigin.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux and high volume web sites
Message-ID: <20010501080850.B30631@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Tim Moore <timothymoore@bigfoot.com>,
	David Lang <david.lang@digitalinsight.com>,
	valery <valery.brasseur@atosorigin.com>,
	linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104280109430.15628-100000@dlang.diginsite.com> <3AEB2E25.E7404FAF@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AEB2E25.E7404FAF@bigfoot.com>; from timothymoore@bigfoot.com on Sat, Apr 28, 2001 at 01:55:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also make sure you aren't suffering database lock contention from Mysql.  This
causes very fast context switching on the database server, and is typically
unable to do useful work even though its load avg is not high.  "vmstat" is
useful here.

Sean

On Sat, Apr 28, 2001 at 01:55:01PM -0700, Tim Moore wrote:
> David Lang wrote:
> > 
> > watch the resonate heartbeat and see if it is getting lost in the network
> > traffic (the resonate logs will show missing heartbeat packets). think
> > seriously of setting the resonate stuff to run at a higher priority so
> > that it doesn't get behind.
> > 
> > depending on how high your network traffic is seriously look at putting in
> > a second nic and switch to move the NFS traffic off the network that has
> > the internet traffic and hearbeat.
> > 
> > I had the same problem with central dispatch a couple years ago when first
> > implementing it. the exact details of the problem that I ran into should
> > have been fixed by now (mostly having to do with large number of virtual
> > IP addresses) but the symptoms were the same.
> 
> In addition to the above make sure there's enough bandwidth to the filer
> (eg- good switches, multiple ethernets).
> 
> Consider moving to 2.2.19.  Significant VM changes after 2.2.19pre3 which
> could account for the freezes.
> 
> rgds,
> tim.
> 
> > > I have a high volume web site under linux :
> > > kernel is 2.2.17
> > > hardware is 5 bi-PIII 700Mhz / 512Mb, eepro100
> > > all server are diskless (nfs on an netapp filer) except for tmp and swap
> > >
> > > dispatch is done by the Resonate product
> > >
> > > web server is apache+php (something like 400 processes), database
> > > backend is a mysql on the same hardware
> > >
> > > in high volume from time to time machines are "freezing" then after a
> > > few seconds they "reappear" and response timne is
> > >
> > >
> > > how can I investigate all these problems ?
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
