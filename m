Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWHHPmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWHHPmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWHHPmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:42:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65494 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964966AbWHHPma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:42:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Suspend on Dell D420
Date: Tue, 8 Aug 2006 17:41:23 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
References: <20060804162300.GA26148@uio.no> <200608081604.00665.rjw@sisk.pl> <20060808150136.GA16272@uio.no>
In-Reply-To: <20060808150136.GA16272@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081741.24099.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 17:01, Steinar H. Gunderson wrote:
> On Tue, Aug 08, 2006 at 04:04:00PM +0200, Rafael J. Wysocki wrote:
> > Please apply the appended patch to the SMP kernel and try the following:
> >
> > [...]
> >
> > I think (1) will work and (2) will not, but let's see. :-)
> 
> Actually, both worked just fine. The first one (testproc) gave me EPERM on
> the actual write call according to echo, but I guess that's just a side
> effect of sloppy test code :-)

Oh, I just forgot to initialize error in kernel/power/disk.c#prepare_processes.c .
Sorry.

However, this means the drivers' suspend and resume routines seem to work fine
and the problem is somehow related to the BIOS black magic that happens
during the "real" suspend.

No idea what to do next. :-(

Rafael
