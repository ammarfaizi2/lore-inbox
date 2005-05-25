Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVEYNGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVEYNGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVEYNGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:06:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38623 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262337AbVEYNGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:06:34 -0400
Date: Wed, 25 May 2005 15:05:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4, -mm: bad ide-cs problems
Message-ID: <20050525130541.GA1960@elf.ucw.cz>
References: <20050525112745.GA1936@elf.ucw.cz> <20050525112824.GA2892@elf.ucw.cz> <42946451.9070301@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42946451.9070301@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > hde: cache flushes not supported
> >  hde: hde1
> > ide-cs: hde: Vcc = 3.3, Vpp = 0.0
> >  hde: hde1
> >  hde: hde1
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000010
> >  printing eip:
> > c033d618
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c033d618>]    Not tainted VLI
> > EFLAGS: 00010292   (2.6.12-rc4)
> > EIP is at ide_drive_remove+0x8/0x10
> > eax: c07825f8   ebx: c0782704   ecx: c07826f0   edx: 00000000
> > esi: c07826e0   edi: c065fed8   ebp: 00000001   esp: dfce5e84
> > ds: 007b   es: 007b   ss: 0068
> > Process pccardd (pid: 932, threadinfo=dfce4000 task=dfc84a40)
> > Stack: c02dc4b4 c07826e0 c065fa00 c0782568 c02dc724 c07826e0 c0782a80
> > c02db5e2
> >        c07826e0 df373a80 c02db628 c07825f8 c033bcfb c0782568 00000002
> > df373b80
> >        df373b80 c0670680 c0670728 c034f63b df758200 00000000 c034f67a
> > c0386108
> > Call Trace:
> >  [<c02dc4b4>] device_release_driver+0x74/0x80
> 
> Pavel,
> I had a similar problem which I fixed amd posted to lkml a while ago
> though I seems to got ignored by the ide maintainer. Please see if this
> helps in your case:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111409743421578&w=2

Yes, thanks, that works. Andrew, is there reason not to push that
patch into -mm/linus?
								Pavel
