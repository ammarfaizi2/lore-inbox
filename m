Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVCDOp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVCDOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVCDOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:45:28 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:47084 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263028AbVCDOmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:42:32 -0500
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on
	battery power)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
In-Reply-To: <200503041415.35162.rjw@sisk.pl>
References: <200502252237.04110.rjw@sisk.pl>
	 <200503030902.48038.rjw@sisk.pl> <20050304110408.GL1345@elf.ucw.cz>
	 <200503041415.35162.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1109947460.3772.270.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 01:44:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 00:15, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, 4 of March 2005 12:04, Pavel Machek wrote:
> > Hi!
> > 
> > > > IIRC kernel code/data is marked as PageReserved(), that's why we need
> > > > to save that :(. Not sure what to do with data e820 marked as
> > > > reserved...
> > > 
> > > Perhaps we need another page flag, like PG_readonly, and mark the pages
> > > reserved by the e820 as PG_reserved | PG_readonly (the same for the areas
> > > that are not returned by e820 at all).  Would that be acceptable?
> > 
> > This flags are little in the short supply, but being able to tell
> > kernel code from memory hole seems like "must have", so yes, that
> > looks ok.
> > 
> > You could get subtle and reuse some other pageflag. I do not think
> > PG_reserved can have PG_locked... So using for example PG_locked for
> > this purpose should be okay.
> 
> The following patch does this.  It is only for x86-64 without
> CONFIG_DISCONTIGMEM, but it has no effect in other cases.

Oops! That's what you get for replying to earlier messages before you
read later ones! The patch I posted has been in use for quite a while,
so it might be helpful to compare anyway.

Regards,

Nigel 

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


