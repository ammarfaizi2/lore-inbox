Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVCJLcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVCJLcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 06:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCJLcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 06:32:21 -0500
Received: from 62-177-247-250.dyn.bbeyond.nl ([62.177.247.250]:40975 "EHLO
	www.ithos.nl") by vger.kernel.org with ESMTP id S262518AbVCJLcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 06:32:14 -0500
Date: Thu, 10 Mar 2005 01:47:37 +0100 (CET)
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
X-X-Sender: rbultje@www.ithos.nl
To: Jean Delvare <khali@linux-fr.org>
cc: Chris Wright <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>, Gerd Knorr <kraxel@bytesex.org>,
       stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
In-Reply-To: <6TEha2ac.1110452170.7309170.khali@localhost>
Message-ID: <Pine.LNX.4.56.0503100141390.22284@www.ithos.nl>
References: <6TEha2ac.1110452170.7309170.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

thanks for the reply.

On Thu, 10 Mar 2005, Jean Delvare wrote:
> I'm glad to learn you are testing things. Still the oops in saa7110 went
> unnoticed for the past 3 months, so I guess that either you don't have
> a DC10(+) in your test panel, or you did not test mm/rc kernels.

I indeed don't test RC/MM kernels. I'm fairly happy with the current
driver status, so I'm not doing any active new development on it. I run
standard Fedora kernels with CVS of the driver (which is the same as
what's in 2.6.10).

> BUZ:
> Input (saa7111): works
> Output (saa7185): no init, cannot set norm

I have this card, but it's no in my computer (not enough PCI slots). Last
test is from a few months back. Other people (co-developers) test this for
me whenever I make small driver changes. They report that it works,
whatever that means. ;). I know they regularly use it for capture, so at
least MJPEG capture and overlay display has to work to some degree. Output
may be untested.

> DC10:
> Input (saa7110): oops
> Output (adv7175): no init, cannot set norm
>
> DC30:
> Input (vpx3220): works
> Output (adv7175): no init, cannot set norm

I have those two. Both work fine. I test raw capture, MJPEG capture and
overlay display at least once a week. I don't get an oops on the DC10. I
haven't tested output lately. I basically only test output when I make
changes to the relevant modules, and I haven't done that lately. Last time
I tested it (which must be around the time the driver was integrated into
the kernel, so before 2.6.0...), it worked for me.

> LM33:
> Input (bt819): no init
> Output (bt856): works
>
> LM33R10:
> Input (saa7114): no init, cannot set norm
> Output (adv7170): no init, cannot set norm

See Buz.

> As you can see, all boards are affected at some level but every user
> might not be equally affected, depends whether you use input or output
> or both. Note that "no init" might not affect everyone either, depends
> on the chip init defaults and the user needs. Ronald, can you tell us
> what exactly in the above you are testing?

My experience is not the same as yours, it seems... I cannot explain why,
unfortunately. Again, I'm sure your patch is correct, I'm just reporting
that I'm not seeing the same thing that you're seeing.

Ronald
