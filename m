Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbTJXWYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJXWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:24:18 -0400
Received: from gprs146-242.eurotel.cz ([160.218.146.242]:29057 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262692AbTJXWYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:24:02 -0400
Date: Sat, 25 Oct 2003 00:23:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031024222347.GB728@elf.ucw.cz>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xbrs6652m.fsf@kth.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I've been trying the new suspend to disk implementation (pmdisk, I
> >>think) lately.  I get these lines in the kernel log when starting
> >>after a suspend:
> >>
> >>PM: Reading pmdisk image.
> >>PM: Resume from disk failed.
> >>ACPI: (supports S0 S1 S3 S4 S5)
> >>
> >>Last time I tried swsusp, I did pass the resume= option, but it didn't
> >>work.
> >>
> >>Could it be that some disk cache is never flushed properly?
> >>Occasionally, some random filesystem is reported as not being cleanly
> >>unmounted when booting normally, which seems to point in the same
> >>direction.
> >>
> >
> > Try turning your disk cache off, or set it to write through caching
> > (even so I heard some IDE drives don't turn it off anyway!). See if
> > it helps.
> 
> That took me one step further.  Now it loaded the image swap, but them
> immediately rebooted.  I didn't have time to see if there were any
> error messages.  I don't have a serial port, so I can't put a console
> there.  This was with lots of modules loaded, so maybe unloading some
> would help.  Are there any known broken drivers in this list:

Try it completely without modules. I'm not sure how it should work
with modules which means it probably does not work at all.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
