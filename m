Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWAML0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWAML0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWAML0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:26:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:37563 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964923AbWAML0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:26:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 12:28:19 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601122241.07363.rjw@sisk.pl> <200601130031.34624.rjw@sisk.pl> <20060113001640.GD10088@elf.ucw.cz>
In-Reply-To: <20060113001640.GD10088@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131228.19719.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 13 January 2006 01:16, Pavel Machek wrote:
> > > > +commands defined in kernel/power/power.h.  The major and minor
> > > > +numbers of the device are, respectively, 10 and 231, and they can
> > > > +be read from /sys/class/misc/snapshot/dev.
> > > 
> > > Is this still true?
> > 
> > You mean the /sys/class/misc/snapshot/dev?  Yes, until sysfs gets revamped.
> 
> Ahha, but it is not your code but misc-handling code in kernel, right?

Yup.

> > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > > +	should be a pointer to an unsigned int variable that will contain
> > > > +	the result if the call is successful)
> > > 
> > > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > > available swap can be >4GB. [Or maybe it is in something else than
> > > bytes, then you need to specify it.]
> > 
> > It returns the number of pages.  Well, it should be written explicitly,
> > so I'll fix that.
> > 
> > [This feature is actually useful, because it allows you to check if you have
> > enough swap after creating the snapshot and retry for eg. image_size = 0
> > without unfreezing tasks.]
> 
> Ok. [I was asking about unsigned int, it is clear that querying
> available swap is useful]. If you return swap offsets, you may want to
> specify if it is #bytes/#pages, too.

Yes, I'll do that.

Greetings,
Rafael
