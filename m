Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbULVVYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbULVVYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 16:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbULVVYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 16:24:51 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5829 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262047AbULVVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 16:24:48 -0500
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two
	stage V2.]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041222202831.GB7051@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com>
	 <20041120003010.GG1594@elf.ucw.cz>
	 <1103585300.26640.47.camel@desktop.cunninghams>
	 <20041222202831.GB7051@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1103750502.10045.27.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 23 Dec 2004 08:21:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-12-23 at 07:28, Pavel Machek wrote:
> Hi!
> 
> > On Sat, 2004-11-20 at 11:30, Pavel Machek wrote:
> > > --- clean/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
> > > +++ linux/Documentation/power/devices.txt	2004-11-03 02:16:40.000000000 +0100
> > > @@ -141,3 +141,82 @@
> > >  The driver core will not call any extra functions when binding the
> > >  device to the driver. 
> > >  
> > > +pm_message_t meaning
> > > +
> > > +pm_message_t has two fields. event ("major"), and flags.  If driver
> > > +does not know event code, it aborts the request, returning error. Some
> > > +drivers may need to deal with special cases based on the actual type
> > > +of suspend operation being done at the system level. This is why
> > > +there are flags.
> > > +
> > 
> > I don't know how I managed to miss this before, but I think it's
> > definitely a step in the right direction. I do wonder, though, if we're
> > going about this whole thing in a peacemeal approach. I feel like the
> > whole issue of power state management on the system wide and driver
> > level are being treated as two separate issues. Is it just me?
> 
> Well, we are starting with small steps... And since nobody knows how
> to do one-device-suspend properly, we started with fixing system
> suspend first.
> 
> Passing structure instead of u32 should make one-device-suspend easier
> in future... Hopefully.

I could spend some time working on a proposal for this, if you like. It
would probably do me good in preparation for my presentation on 2.6 PM
(in general) at the CELF Linux Form next month.

Regards,

Nigel
-- 
Nigel Cunningham
Cyclades Software Engineer
Canberra, Australia

http://www.cyclades.com

+61 (2) 6292 8028
+61 (417) 100 574

