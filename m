Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSGCK4I>; Wed, 3 Jul 2002 06:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSGCK4H>; Wed, 3 Jul 2002 06:56:07 -0400
Received: from 89dyn229.com21.casema.net ([62.234.20.229]:61390 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S316992AbSGCK4G>; Wed, 3 Jul 2002 06:56:06 -0400
Message-Id: <200207031057.MAA03204@cave.bitwizard.nl>
Subject: Re: sync slowness. ext3 on VIA vt82c686b
In-Reply-To: <20020703094031.GA4462@lnuxlab.ath.cx> from khromy at "Jul 3, 2002
 05:40:31 am"
To: khromy <khromy@lnuxlab.ath.cx>
Date: Wed, 3 Jul 2002 12:57:45 +0200 (MEST)
CC: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> On Wed, Jul 03, 2002 at 10:22:44AM +0100, Stephen C. Tweedie wrote:
> > Ugh.  My first guess would be that you have one enormously fragmented
> > filesystem.  13MB in 2 minutes?  A modern disk should get that amount
> > of data to disk in one second, but massive fragmentation can simply
> > kill disk performance.
> > 
> > If /home is on the same disk, do you get the same problem trying to
> > write there?
> 
> Yeah, /home/ is on the same disk.  Your guess might be right because
> that's what I was trying to show.  When I copy the file, which is in
> /home/(hda2) to /tmp/(hda1) and I sync, it takes almost 2 minutes.  But 
> if I copy the same file, which is in /home/(hda2) to /usr/local/(hda3),
> sync returns immediately.  This disk isn't that old either.

Get your data off that disk Immediately!

If you write a large file, ext2 will do a good job not fragmenting the
file. You should be able to get about 20M per second on a sequential
writes, about 10M per second, if your filesystem is badly fragmented.

So, the drive is taking abnormally long to read/write blocks. That is
an indication that it's "going to die soon".

That said, maybe there is a whole lot of (random) reads going on 
on that disk? Are you swapping at the same time? Or maybe your
dayly "updatedb" is running?

Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
