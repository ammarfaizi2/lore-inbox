Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWAGT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWAGT2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWAGT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:28:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17671 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161016AbWAGT2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:28:37 -0500
Date: Fri, 6 Jan 2006 04:30:19 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060106043019.GA2545@ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net> <20060105234327.GA2951@ucw.cz> <200601071604.03846.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601071604.03846.lkml@spitalnik.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-01-06 16:04:03, Jan Spitalnik wrote:
> Dne pátek 06 leden 2006 00:43 Pavel Machek napsal(a):
> > On Fri 06-01-06 19:45:09, Jan Spitalnik wrote:
> > > Hello,
> > >
> > > suspending to disk is not supported on CONFIG_HIGHMEM64G setups
> > > (http://suspend2.net/features). Also suspend to ram doesn't work. This
> > > patch
> >
> > NAK. suspend2.net describes very different code.
> 
> Well, I was using suspend2.net's page just as reference, to point out the fact 
> that HIGHMEM is on both suspend "platforms" supported only up to 4G. 
> I was not refering to suspend2's actual features, but rather swsusp's 
> (or what's the proper name for suspend1 code). So i guess the patch still 
> holds, no?

No.

> > > fixes Kconfig to disallow such combination. I'm not 100% sure about the
> > > ACPI_SLEEP part, as it might be disabling some working setup - but i
> > > think that s2r and s2d are the only acpi sleeps allowed, no?
> >
> > s2ram probably works. Try getting it working without highmem64,
> > then turn it on.
> 
> It works with HIGHMEM but not HIGHMEM64G. You can find the oops from 
> HIGHMEM64G below. It crashes very reliably on little stress after resume.
> 

s2ram should not depend on ammount of memory. Try debugging
it, but do not disable feature just because it does not work
for you. I'd start with minimum drivers...

-- 
Thanks, Sharp!
