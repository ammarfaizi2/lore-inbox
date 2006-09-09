Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWIIN2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWIIN2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIIN2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 09:28:43 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:4293 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932178AbWIIN2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 09:28:42 -0400
Date: Sat, 9 Sep 2006 15:33:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
Message-ID: <20060909133334.GB17085@uranus.ravnborg.org>
References: <20060909110245.GA9617@havoc.gtf.org> <Pine.LNX.4.63.0609091453200.29522@alpha.polcom.net> <4502C086.2080302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4502C086.2080302@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 09:24:22AM -0400, Jeff Garzik wrote:
> Grzegorz Kulewski wrote:
> >On Sat, 9 Sep 2006, Jeff Garzik wrote:
> >>An IRC discussion sparked a memory:  most filesystems really don't
> >>need to put anything at all in include/linux.  Excluding API-ish
> >>filesystems like procfs, just about the only filesystem symbols that
> >>get exported outside of __KERNEL__ are the *_SUPER_MAGIC symbols,
> >>and similar symbols.
> >>
> >>After seeing the useful attributes of linux/poison.h, I propose a
> >>similar linux/magic.h.
> >
> >But... if some patch changes this file (like adding new magic symbol) it 
> >will cause large part of the kernel to rebuild without any good reason. No?
> 
> No :)
> 
> * The days when linux/fs.h included individual filesystem headers is 
> long gone.  Only the filesystems themselves typically include the 
> linux/foo_fs*.h files these days.

But do we want one common set of magic numbers or do we try to divide it
up per subssystem. The lattter approach are used for many other purposes
so why not for magics too?
Or in other word magic.h => fs_magic.h

	Sam
