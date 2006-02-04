Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946225AbWBDAt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946225AbWBDAt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946226AbWBDAt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:49:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30873 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946225AbWBDAt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:49:57 -0500
Date: Sat, 4 Feb 2006 01:49:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204004944.GE3291@elf.ucw.cz>
References: <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <200602030918.07006.nigel@suspend2.net> <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com> <20060202171812.49b86721.akpm@osdl.org> <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com> <20060203114948.GC2972@elf.ucw.cz> <1139010204.2191.14.camel@coyote.rexursive.com> <20060203235546.GB3291@elf.ucw.cz> <20060204003659.GC4845@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204003659.GC4845@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 04-02-06 01:36:59, Olivier Galibert wrote:
> On Sat, Feb 04, 2006 at 12:55:47AM +0100, Pavel Machek wrote:
> > The weird reasons were stated few times already. My favourite weird
> > reason is "can be done in userspace" these days.
> 
> Oh please, stop that.  Network can be done in userspace.  NFS can be
> done in userspace.  Filesystems can be done in userspace.  You need a
> better reason than that.

I have few more. That was my favourite :-).

> Now the pressure to add progress bar and other chrome, I can
> understand.  Not wanting the chrome in the kernel, I understand even
> more.  Deciding the solution for that is to more everything in

Good.

> Why don't you try to design the system so that the progress bar can't
> fuck up the suspend unless they really, really want to?  Instead of
> one where a forgotten open(O_CREAT) in a corner of graphics code can
> randomly trash the filesystem through metadata corruption?

Even if I only put chrome code to userspace, open() would still be
deadly. I could do something fancy with disallowing syscalls, but it
is probably easier to just read the chrome code to be used... It
should be as simple as memcpy(framebuffer, prepared image).

								Pavel
-- 
Thanks, Sharp!
