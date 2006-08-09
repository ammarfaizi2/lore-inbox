Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWHIAWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWHIAWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWHIAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:22:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45719 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030364AbWHIAWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:22:15 -0400
Date: Wed, 9 Aug 2006 02:21:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Message-ID: <20060809002159.GE4886@elf.ucw.cz>
References: <20060804162300.GA26148@uio.no> <200608081604.00665.rjw@sisk.pl> <20060808150136.GA16272@uio.no> <200608081741.24099.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608081741.24099.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-08-08 17:41:23, Rafael J. Wysocki wrote:
> On Tuesday 08 August 2006 17:01, Steinar H. Gunderson wrote:
> > On Tue, Aug 08, 2006 at 04:04:00PM +0200, Rafael J. Wysocki wrote:
> > > Please apply the appended patch to the SMP kernel and try the following:
> > >
> > > [...]
> > >
> > > I think (1) will work and (2) will not, but let's see. :-)
> > 
> > Actually, both worked just fine. The first one (testproc) gave me EPERM on
> > the actual write call according to echo, but I guess that's just a side
> > effect of sloppy test code :-)
> 
> Oh, I just forgot to initialize error in kernel/power/disk.c#prepare_processes.c .
> Sorry.
> 
> However, this means the drivers' suspend and resume routines seem to work fine
> and the problem is somehow related to the BIOS black magic that happens
> during the "real" suspend.
> 
> No idea what to do next. :-(

(Can we get bugzilla entry? I somehow lost track).

Can you try with method=powerdown or method=reboot? BIOS black magic
is not involved at least in reboot parts...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
