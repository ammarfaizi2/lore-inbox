Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264215AbRGCMLS>; Tue, 3 Jul 2001 08:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264259AbRGCMLI>; Tue, 3 Jul 2001 08:11:08 -0400
Received: from mail.intrex.net ([209.42.192.246]:44552 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S264215AbRGCMKw>;
	Tue, 3 Jul 2001 08:10:52 -0400
Date: Tue, 3 Jul 2001 08:15:15 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: modules and 2.5
Message-ID: <20010703081515.B1146@bessie.localdomain>
In-Reply-To: <3B415489.77425364@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B415489.77425364@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Jul 03, 2001 at 01:13:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 01:13:45AM -0400, Jeff Garzik wrote:
> A couple things that would be nice for 2.5 is
> - let MOD_INC_USE_COUNT work even when module is built into kernel, and
> - let THIS_MODULE exist and be valid even when module is built into
> kernel

I have something similar that I have wanted for a long time, and it would
accomplish what you want too.  I would like for the .o files for modules and
compiled in drivers to be identical.  It seems like this would be better for
testing because it should eleminate module vs non-module bugs.  We might
even want them to show up in /proc/modules, perhaps with some mechinism to
keep the reference count from going to 0.

I dont think I would want to unleash it on an end user, but if you omit the
part about letting the reference count go to zero, it should even be possible
to unload a compiled in driver and replace it with a new module.  If you
did not load each module into its own section, you would have to leak its
text and data memory, but this still might be useful for development.

Anyway, just some ideas I have been wanting to share for about 5 years.
Thanks for giving me an excuse.

Jim
