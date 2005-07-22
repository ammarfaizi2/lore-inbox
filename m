Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVGVOt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVGVOt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVGVOt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:49:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57786 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262103AbVGVOsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:48:55 -0400
Date: Fri, 22 Jul 2005 16:48:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-ID: <20050722144855.GA2036@elf.ucw.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com> <9a8748490507211114227720b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490507211114227720b0@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd gladly (ehum..) redo this mind-numbingly boring test if someone can
> > point me to a magic software which unleashes some untapped powersaving
> > feature of the CPU.
> > 
> > _Kernel 2.6.13-rc3 Boot to Death_:
> > 
> > 2h48m at 100 HZ
> > 2h48m at 250 HZ
> > 2h47m at 1000 HZ
> > 
> > _"Load"_:
> > 
> > #!/bin/sh
> > touch time-hz-start
> > while (true) do
> >     touch time-hz-end
> >     sleep 1m
> > done
> > 
> Ok, so with an idle machine, different HZ makes no noticeable
> difference, but I'd suspect things would be different if the machine
> was actually doing some work.
> Would be more interresting to see how long it lasts with a light load
> and with a heavy load.

No, I do not think so. Biggest difference should be on completely idle
machine where ACPI can utilize low power states.

Can you check that C3 is utilized? Unloading usb modules may be
neccessary...

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
