Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbULVU2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbULVU2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbULVU2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:28:49 -0500
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:34178 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262031AbULVU2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:28:46 -0500
Date: Wed, 22 Dec 2004 21:28:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041222202831.GB7051@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <1103585300.26640.47.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103585300.26640.47.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Sat, 2004-11-20 at 11:30, Pavel Machek wrote:
> > --- clean/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
> > +++ linux/Documentation/power/devices.txt	2004-11-03 02:16:40.000000000 +0100
> > @@ -141,3 +141,82 @@
> >  The driver core will not call any extra functions when binding the
> >  device to the driver. 
> >  
> > +pm_message_t meaning
> > +
> > +pm_message_t has two fields. event ("major"), and flags.  If driver
> > +does not know event code, it aborts the request, returning error. Some
> > +drivers may need to deal with special cases based on the actual type
> > +of suspend operation being done at the system level. This is why
> > +there are flags.
> > +
> 
> I don't know how I managed to miss this before, but I think it's
> definitely a step in the right direction. I do wonder, though, if we're
> going about this whole thing in a peacemeal approach. I feel like the
> whole issue of power state management on the system wide and driver
> level are being treated as two separate issues. Is it just me?

Well, we are starting with small steps... And since nobody knows how
to do one-device-suspend properly, we started with fixing system
suspend first.

Passing structure instead of u32 should make one-device-suspend easier
in future... Hopefully.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
