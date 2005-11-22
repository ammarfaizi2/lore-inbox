Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVKVTBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVKVTBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVKVTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:01:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21694 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965112AbVKVTBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:01:19 -0500
Date: Tue, 22 Nov 2005 19:59:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051122185900.GD1748@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com> <20051119234850.GC1952@spitz.ucw.cz> <200511220026.55589.dtor_core@ameritech.net> <871x19giuw.fsf@obelix.mork.no> <20051122174643.GB1752@elf.ucw.cz> <d120d5000511221045x35cfb416q67c855414b896315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000511221045x35cfb416q67c855414b896315@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If a clueless users voice counts for anything: I couldn't agree more.
> > >
> > > A failed resume is a near catastrophy if you use and trust swsusp. And
> > > how could it ever be useful if you don't?
> >
> > Failed resume is only as bad as powerfail.
> 
> So? I don't like powerfails either. Could you please answer this
> question - what pros of having resume process time out do you
> envision? What problems does it help to solve?

No advantages, really.. except that it keeps suspend and resume paths
similar, and keeps the code simple. I'll want to call this from
userland and I'd hate to have two different calls or call with
parameter.

> > > Maybe that even would give me a chance to fix some hardware problem
> > > causing the timeout, and then retry the resume.
> >
> > ..while doing resume few times, trying to change hw config to make it
> > resume is _way_ more dangerous.
> 
> And still we have to do our best to support it. There is USB,
> Firewire, Docking station that may appear/disappear while box is
> suspended and we absolutely need to support this. Requiring that
> hardware configuration has to be frozen between suspend/resume cycles
> will not get us far.

You may plug/unplug things that are hot-pluggable. If you do something
else (imagine adding or worse removing ram from the system), or do
something "interesting" (boot freebsd, mount ext3 partition,
...)... you loose your data.
								Pavel
-- 
Thanks, Sharp!
