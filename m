Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVHBOjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVHBOjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVHBOHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:07:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42926 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261534AbVHBOFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:05:52 -0400
Date: Tue, 2 Aug 2005 16:05:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gene Pavlovsky <heilong@bluebottle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFE: console_blank_hook that calls userspace helper
Message-ID: <20050802140543.GA2465@atrey.karlin.mff.cuni.cz>
References: <1122891737.42edf7d9a402a@www.bluebottle.com> <20050802110418.GB1390@elf.ucw.cz> <42EF7CB7.5090403@bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF7CB7.5090403@bluebottle.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I can try to do this, but it will have to wait, I've got too much work now.
> Don't you think the userspace solution deserves a try?

Well, how do you unblank when something bad happens
(oops,panic?). Blanking should really be done from kernel.
								Pavel

> >>http://bugzilla.kernel.org/show_bug.cgi?id=4767:
> >>
> >>Bugzilla Bug 4767 	RFE: console_blank_hook that can call userspace
> >>program
> >>Submitter:   	heilong@bluebottle.com (Eugene Pavlovsky)
> >>
> >>I think it'd be very good to have a console_blank_hook handler that
> >>would call a
> >>userspace program/script/generate hotplug event whatever. Currently,
> >>the console
> >>can only be blanked using APM, so no options exist for people using
> >>ACPI. I've
> >>got a Radeon graphics chip on my laptop, and the LCD backlight can be
> >>controlled
> >>(on/off) using radeontool. If there was a userspace callback
> >>interface
> >>to
> >>console blanking, I would just make a callback script that calls
> >>"radeontool
> >>light off" on blank and "radeontool light on" on unblank - really
> >>easy. I think
> >>this userspace console_blank_hook handler is very simple to put into
> >>kernel, but
> >>I'm not a kernel developer myself, so wouldn't risk sending any
> >>patches (that
> >>call system("some_script")), because I probably won't make things as
> >>they should
> >>be in the kernel.
> > 
> > 
> > Radeonfb should blank console automatically, without userspace
> > helper. Send a patch to do that ;-).


-- 
Boycott Kodak -- for their patent abuse against Java.
