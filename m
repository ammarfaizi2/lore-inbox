Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWGYTIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWGYTIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWGYTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:08:08 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:9736 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964830AbWGYTIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:08:06 -0400
Date: Tue, 25 Jul 2006 15:07:47 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725190747.GH4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <857D7DE9-D1F6-4A66-91F2-BC4D9044D42C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857D7DE9-D1F6-4A66-91F2-BC4D9044D42C@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:56:14PM +0200, Segher Boessenkool wrote:
> >>Similar functionality is already available via VDSO on
> >>platforms that support it (currently PowerPC and AMD64?) --
> >>seems like a better way forward.
> >>
> >In general I agree, but that only works if you operate on a  
> >platform that
> >supports virtual syscalls, and has vdso configured.
> 
> That's why I said "a better way forward", not "this already
> works everywhere".
> 
> >I'm not overly familiar
> >with vdso, but I didn't think vdso could be supported on all  
> >platforms/arches.
> 
> Oh?  Which can not, and why?
> 
I'm sorry, I shouldn't say that vdso itself can't be supported, but rather a
vsyscall that doesn't just wind up trapping into the kernel anyway.  Older
systems without a hpet timer to map into user space jump immediately to mind.
Arjan had mentioned a calibration on rdtsc as another alternative, which I had
not considered, so this may all be moot, but I was worried that a vdso solution
wouldn't always give the X guys what they were really after.

Regards
Neil

> 
> Segher

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
