Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRAFR3I>; Sat, 6 Jan 2001 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAFR27>; Sat, 6 Jan 2001 12:28:59 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:48882 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S130029AbRAFR2r>;
	Sat, 6 Jan 2001 12:28:47 -0500
Message-ID: <3A5755D6.5607D908@leoninedev.com>
Date: Sat, 06 Jan 2001 12:28:54 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Wragg <dpw@doc.ic.ac.uk>, linux-kernel@vger.kernel.org
CC: TRoXX@LiquidXTC.nl
Subject: Re: Framebuffer as a module
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu> <y7rk889wk6o.fsf@sytry.doc.ic.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I used to compile-in my framebuffer-device in the kernel
> then i just appended "video=tdfxfb:1024x768-32@70" in lilo.conf and it
> worked..
> now i compiled it as a module, and want modprobe to start it up for me..
> how can this be done?
> modprobe tdfxfb 1024x768-32@70

That's a very good question.  The tdfxfb module has no parameters.  It would be
ideal if the tdfxfb mainatiner would add some MODULE_PARM lines for all the
parameters and move the code from tdfxfb_setup that does work into tdfxfb_init.

I think a valid work-around for you is to use fbset after you load the module
to set the resolution.  Does that work?
Bry

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
