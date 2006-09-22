Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWIVNeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWIVNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWIVNeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 09:34:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44165 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932454AbWIVNeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 09:34:24 -0400
Date: Fri, 22 Sep 2006 15:34:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 4/6] swsusp: Add resume_offset command line parameter
Message-ID: <20060922133421.GA3478@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202146.59105.rjw@sisk.pl> <20060921213143.GE2245@elf.ucw.cz> <200609220018.45198.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609220018.45198.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Add the kernel command line parameter "resume_offset=" allowing us to specify
> > > the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
> > > to by the "resume=" parameter at which the swap header is located.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Okay, I'd prefer not to add aditional features to in-kernel swsusp,
> > but this is just not big enough to reject.
> > 
> > ACK.
> > 
> > (What is the solution for uswsusp?)
> 
> We need an additional ioctl to set both the swap partition and "resume offset"
> at a time (the one we currently have allows us only to set the partition and I
> don't want to change it because of the backwards compatibility, but I think
> I'll change its name ;-) ).
> 
> I'd like to add this ioctl along with the one needed to support the "platform"
> method of powering off, because it will require some similar documentation
> changes (most importantly, the description of the interface in
> Documentation/ABI which I'd like to add once and not to tamper with
> afterwards).

Ok, agreed.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
