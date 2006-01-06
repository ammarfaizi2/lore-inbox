Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWAFWou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWAFWou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWAFWou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:44:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964874AbWAFWou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:44:50 -0500
Date: Fri, 6 Jan 2006 23:44:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Message-ID: <20060106224430.GC12428@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <20060105233026.GA3339@elf.ucw.cz> <200601062217.09012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601062217.09012.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is the second "preview release" of the swsusp userland interface patches.
> > > They have changed quite a bit since the previous post, as I tried to make the
> > > interface more robust against some potential user space bugs (or outright
> > > attempts to abuse it).
> > 
> > Works for me, thanks.
> > 
> > Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
> > on them...
> 
> OK, I'll prepare them in a while.

Thanks.

> > 2/4 needs to allocate official major/minor. 1/13 would be nice :-).
> 
> Well, you said you liked the patch with a misc device (ie. major = 10).
> 
> Actually the code is somewhat simpler in that case so I'd prefer it.
> 
> Now, if we used a misc device, which minor would be suitable?  231?

If code is simpler, lets stick with misc. You have to obtain minor by
mailing device@lanana.org, see Doc*/devices.txt.

> > 4/4... I'm not sure. It would be nice to make swsusp.c disappear. It
> > is really wrong name. That means we need to only delete from it for a
> > while...
> 
> Anyway I think it would be nice to move the code that does not really belong
> to the snapshot and is used by both the user interface and disk.c/swap.c to
> a separate file.  I have no preference as far as the name of the file is
> concerned, though.

Ok, lets keep it as it is. We can always rename file in future. [I
don't quite understand your reasons for movement, through. Highmem is
part of snapshot we need to make; it is saved in a very different way
than rest of memory, but that is implementation detail...]


									Pavel
-- 
Thanks, Sharp!
