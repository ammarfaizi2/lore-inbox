Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWGaQlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWGaQlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWGaQlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:41:06 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:28073 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030234AbWGaQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:41:05 -0400
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Mon, 31 Jul 2006 09:41:00 -0700
User-Agent: KMail/1.7.1
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607310733.09125.david-b@pacbell.net> <20060731181327.d54ce1d0.khali@linux-fr.org>
In-Reply-To: <20060731181327.d54ce1d0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607310941.01340.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
> Hi David,
> 
> > And I **really** hope this gets merged into 2.6.18 since virtually
> > no OMAP board is very usable without it.  I2C is one of the main
> > missing pieces(*) ... can whoever's managing I2C merges please
> > expedite this?
> 
> It doesn't work like this, sorry. The merge window for 2.6.18 is
> closed. The driver needs to be reviewed before it is merged. So the
> best you can hope for is -mm soon, and 2.6.19.

So there's been a change from the "new drivers can be merged late"
policy?  News to me if so.  Not that this is a particularly new
driver of course, or at all unstable.


> > I just tried building an OSK config against RC3 and found at least
> > five will-not-build errors in the kernel.org tree.  The reason for
> > this is basically that folk have no option except the linux-omap
> > tree, since there's no point in trying to use the kernel.org version
> > until the I2C driver finally gets merged ... so such bugs won't get
> > fixed.  Needless to say, this is not the desired development process.
> 
> Indeed, this is no good. If you want things to improve, please help by
> reviewing Komal's driver. I think I understand you already commented on
> it, but I'd like you to really review it, and add a formal approval to
> it (e.g. Signed-off-by or Acked-by). Then I'll review it for merge.

Review it again?  I'll try to make some time to help there, but
it's unlikely I'll notice significant issues that seem to me
worth holding up the upstream merge.  Certainly none that make
up for the problems caused by having the kernel.org tree be all
but unusable for OMAP work, and couldn't be patched later.


> > (*) I submitted the then-current I2C driver over a year ago, but
> >     after a few months of inaction I found that it was dropped
> >     (or rejected?) by the I2C list software.  Of course at that
> >     point I no longer had time to resubmit the current code ...
> 
> Neither dropped nor rejected, as I received it and it shows in the
> archive as well:
>   http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013216.html
> The reason why it was "ignored" is more likely a lack of time and/or
> interest.
> 
> What is the relation between your "old" driver

Not "my" driver at all; I'm not even on the copyright list, and
maybe the biggest change I did was the platform_driver conversion.
(If that; I don't recall, but I converted a lot of drivers around
that time and I think I probably did that one too.)


> and the new one Komal is 
> submitting now? Evolution, or rewrite?

Evolution.  I see support for the new OMAP2 parts (ARMv6) and maybe
the clock framework stuff is new; plus as you know the I2C framework
has collected simplifications and updates.

- Dave
