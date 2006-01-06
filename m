Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWAFX75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWAFX75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAFX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:59:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31972 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932680AbWAFX7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:59:55 -0500
Date: Sat, 7 Jan 2006 00:59:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Message-ID: <20060106235934.GA20399@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <200601062217.09012.rjw@sisk.pl> <20060106224430.GC12428@elf.ucw.cz> <200601070041.22497.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601070041.22497.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
> > > > on them...
> > > 
> > > OK, I'll prepare them in a while.
> > 
> > Thanks.
> 
> I had to remake the 3/4 a bit, as it depended on some changes to power.h
> and swsusp.c done in the 2/4.  Nothing particularly invasive, basically some
> definitions go to power.h and some function headers change, but please
> have a look if the patch is still OK (appended).

Still ok :-).

> > If code is simpler, lets stick with misc. You have to obtain minor by
> > mailing device@lanana.org, see Doc*/devices.txt.
> 
> OK, I'll try.

It should be easy.

> > Ok, lets keep it as it is. We can always rename file in future. [I
> > don't quite understand your reasons for movement, through. Highmem is
> > part of snapshot we need to make; it is saved in a very different way
> > than rest of memory, but that is implementation detail...]
> 
> I'm seeing this a bit differently.  In my view highmem is handled very much
> like devices: save_highmem() turns it "off", restore_highmem() turns it "on"
> back again, they are even called next to device_power_up/down().

Yes, I guess it is possible to view it like that, too.

BTW your "write 500MB to swap" hit mainline few hours
ago. Congratulations.

								Pavel
-- 
Thanks, Sharp!
