Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCLXIk>; Tue, 12 Mar 2002 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCLXIb>; Tue, 12 Mar 2002 18:08:31 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:4616 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S288377AbSCLXIV>;
	Tue, 12 Mar 2002 18:08:21 -0500
Date: Tue, 12 Mar 2002 00:28:17 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
Message-ID: <20020312002816.A37@toy.ucw.cz>
In-Reply-To: <3C8CA5D8.50203@evision-ventures.com> <E16kRZp-0000or-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16kRZp-0000or-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 11, 2002 at 03:19:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > the WB
> >    caches of IDE devices are not caches in the sense of a MESI cache, 
> > they are
> >    more like buffer caches and should therefore flush them self after s 
> > short
> >    period of inactivity without the application of any special flush 
> > command.
> 
> You now have an absolute vote of *NO CONFIDENCE* on my part. I'm simply
> not going to consider running your code. "It probably wont eat your disk"
> and handwaving is not how you write a block layer.

This is S3/S4 support. Not used during normal operation. S3/S4 without this
is as dangerous as "oops, we've written wrong data to wrong place, without
even knowing that". With this, the problem is "maybe your hdd is not initialized
properly, so you lost ability to talk to it".

> How is anyone supposed to debug file system code in 2.5 when its known
> that it will trash data on some disks anyway ? I'd like to see you cite

It will not. This is only used when ACPI suspend-to-disk/suspend-to-ram
is used (and at that time, you have worse problems than IDE driver).
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

