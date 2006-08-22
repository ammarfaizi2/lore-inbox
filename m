Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHVSYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHVSYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHVSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:24:51 -0400
Received: from bender.bawue.de ([193.7.176.20]:55492 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S932331AbWHVSYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:24:50 -0400
Date: Tue, 22 Aug 2006 20:24:41 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: FUSE unmount breaks serial terminal line
Message-ID: <20060822182441.GB6293@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060820180505.GA18283@sommrey.de> <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu> <20060820212840.GA29855@sommrey.de> <E1GFS4R-0007wJ-00@dorka.pomaz.szeredi.hu> <20060822155949.GA4268@sommrey.de> <E1GFYmi-0000Ct-00@dorka.pomaz.szeredi.hu> <20060822174329.GA6293@sommrey.de> <20060822175411.GB31064@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822175411.GB31064@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:54:11PM +0100, Russell King wrote:
> On Tue, Aug 22, 2006 at 07:43:29PM +0200, Joerg Sommrey wrote:
> > On Tue, Aug 22, 2006 at 06:07:24PM +0200, Miklos Szeredi wrote:
> > > > Tested both gphoto2 and gtkam without any problems. There is no impact
> > > > on the serial lines.
> > > > 
> > > > NB: The *real* trouble I have is with ntpd and a reference clock
> > > > attached to /dev/ttyS1.  ntpd enters a busy loop reading ttyS1, stops
> > > > working and eats up 100% CPU.  
> > > > 
> > > > Thanks for your investigations.  Any other idea?
> > > 
> > > Try 'killall -9 gphotofs' and then the 'fusermount -u'.
> > > 
> > > Does that have the same effect?  If so, after which does the serial
> > > line die?
> > 
> > Here are the results and another insight:  only the first serial device
> > open for reading is affected.  I.e. if ttyS0 is open for reading,
> > ttyS1 doesn't break.  If ttyS0 is not open, then ttyS1 breaks.  This
> > happens when gphotofs gets killed (or with fusermount -u without
> > killing).
> 
> Have you checked to see what files gphotofs has open?  (Check in
> /proc/<pid>/fd/).
> 

Sure I did check this.  No ttyS? there.
Thanks anyway!

-jo

-- 
-rw-r--r-- 1 jo users 62 2006-08-22 19:05 /home/jo/.signature
