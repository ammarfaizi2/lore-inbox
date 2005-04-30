Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVD3III@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVD3III (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVD3III
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:08:08 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:30709 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262549AbVD3IIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:08:02 -0400
Date: Sat, 30 Apr 2005 11:10:14 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Greg KH <gregkh@suse.de>
cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO
 etc.
In-Reply-To: <20050430051030.GA10005@suse.de>
Message-ID: <Pine.LNX.4.61.0504301100430.21122@kai.makisara.local>
References: <20050427171446.GA3195@kroah.com> <20050427171649.GG3195@kroah.com>
 <1114619928.18809.118.camel@localhost.localdomain>
 <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
 <1114694511.18809.187.camel@localhost.localdomain> <20050429042014.GC25474@kroah.com>
 <1114805784.18330.297.camel@localhost.localdomain> <20050429203805.GA2959@kroah.com>
 <Pine.LNX.4.61.0504300849350.21122@kai.makisara.local> <20050430051030.GA10005@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Greg KH wrote:

> On Sat, Apr 30, 2005 at 08:52:31AM +0300, Kai Makisara wrote:
> > On Fri, 29 Apr 2005, Greg KH wrote:
> > 
...
> > > Switch it in both capable() calls in the patch?  Kai, is this acceptable
> > > to you also?
> > > 
> > Yes. Using CAP_SYS_ADMIN here was wrong.
> 
> Ok, care to send a new patch that I can use for the next -stable kernel
> release?
> 
Sent in a different message. This patch does not restrict 
usage of SCSI_IOCTL_START_UNIT and SCSI_IOCTL_STOP_UNIT. For tapes, those 
mean load and unload commands. The drive status changes resulting from 
these commands seem to be caught by st otherwise. I will do a patch for 
-12rc later today or tomorrow. It may add changing some st status bits if 
these commands succeed but that is not -stable material.

Thanks for the review for all participants.

-- 
Kai
