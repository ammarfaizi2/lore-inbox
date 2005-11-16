Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVKPTUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVKPTUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKPTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:19:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21165 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751506AbVKPTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:19:37 -0500
Date: Wed, 16 Nov 2005 19:07:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] userland swsusp
Message-ID: <20051116190715.GF2193@spitz.ucw.cz>
References: <200511161700.27239.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511161700.27239.stefan@loplof.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is prototype of userland swsusp. I'd like kernel parts to go in,
> > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> > slightly ugly, OTOH it would be probably overkill to introduce
> > syscalls just for this. (I'll need to add an ioctl for freeing memory
> > in future).
> 
> I'm curious on the restrictions the userspace part would have to accept.
> Can /usr/swsusp.c write to a file? Currently, you allow it, but I doubt

No. Writing to file would trash the filesystem. But you can bmap the file,
then write to the block device.

> whether it would be wise to write to a file after you've snapshotted
> kernel's filesystem state. OTOH, I don't want to reserve a partition just
> for the image. Can userspace allocate memory after ioctl(SYS_FREEZE)?

Better avoid memory allocation.

> I have userspace supported encryption of the image in mind.

Yes, that should be feasible. 
							Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

