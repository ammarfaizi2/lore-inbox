Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTE2LMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTE2LMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:12:17 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:50313 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262032AbTE2LMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:12:15 -0400
Date: Thu, 29 May 2003 13:25:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, pavel@suse.cz, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030529112517.GC1215@elf.ucw.cz>
References: <20030528144839.47efdc4f.akpm@digeo.com.suse.lists.linux.kernel> <20030528215551.GB255@elf.ucw.cz.suse.lists.linux.kernel> <p73wuga6rin.fsf@oldwotan.suse.de> <20030529.023203.41634240.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529.023203.41634240.davem@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    This part won't work on sparc64 because it has separate address spaces
>    for user/kernel.
> 
> Yes, in fact I happen to be working in this area hold on...
> 
> I'm redoing Andi's x86_64 ioctl32 bug fixes more cleanly
> for sparc64 by instead using alloc_user_space().
> 
> Sorry Andi, I just couldn't bring myself to allow those bogus
> artificial limits you added just to fix these bugs... :-)
> 
> This work also pointed out many bugs in this area which should
> be fixed by my stuff. (CDROMREAD* ioctls don't take struct cdrom_read
> they take struct cdrom_msf which is compatible, struct
> cdrom_generic_command32 was missing some members, etc. etc.)
> 
> This is a 2.4.x patch but should be easy to push over to the 2.5.x
> ioctl stuff using the appropriate compat types.

It had to be applied by hand, otherwise okay... Mostly.

What is copy_in_user?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
