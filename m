Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVKOXcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVKOXcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVKOXcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:32:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21709 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932575AbVKOXcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:32:19 -0500
Date: Wed, 16 Nov 2005 00:32:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051115233201.GA10143@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115222549.GF17023@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > This is prototype of userland swsusp. I'd like kernel parts to go in,
>  > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
>  > slightly ugly, OTOH it would be probably overkill to introduce
>  > syscalls just for this. (I'll need to add an ioctl for freeing memory
>  > in future).
> 
> Just for info: If this goes in, Red Hat/Fedora kernels will fork
> swsusp development, as this method just will not work there.
> (We have a restricted /dev/mem that prevents writes to arbitary
>  memory regions, as part of a patchset to prevent rootkits)

If this goes in, you can still keep using old method... I'll not
remove it anytime soon.

> Even it were not for this, the whole idea seems misconcieved to me
> anyway.

...but how do you provide nice, graphical progress bar for swsusp
without this? People want that, and "esc to abort", compression,
encryption. Too much to be done in kernel space, IMNSHO.
							Pavel
-- 
Thanks, Sharp!
