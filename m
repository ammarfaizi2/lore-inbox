Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKQKCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKQKCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKQKCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 05:02:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60324 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750728AbVKQKCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 05:02:31 -0500
Date: Thu, 17 Nov 2005 11:01:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] userland swsusp
Message-ID: <20051117100126.GA15341@elf.ucw.cz>
References: <200511161700.27239.stefan@loplof.de> <20051116190715.GF2193@spitz.ucw.cz> <200511170819.17046.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511170819.17046.stefan@loplof.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No. Writing to file would trash the filesystem. But you can bmap the file,
> > then write to the block device.
> 
> And for reading, I could used a device mapper enforced read only mount or 
> filesystem code from grub.

Or use a filesystem that honours read-only option, like ext2...

> Hmm, how about a possibility to ask the kernel for a list of free pages on a 
> swap device? This way, userspace could write the image to swap as the kernel 
> currently does, avoiding possible trouble with filesystems.

Yes, that is the plan.

> > Better avoid memory allocation.
> 
> And all memory allocated and mapped in advance would be part of the image. But 
> this is totally acceptable for a "suspend helper".

Yes.
									Pavel
-- 
Thanks, Sharp!
