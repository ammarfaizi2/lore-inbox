Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUI0WUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUI0WUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUI0WUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:20:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1977 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S267382AbUI0WUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:20:38 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrea Arcangeli <andrea@novell.com>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040927141652.GF28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
	 <1096071873.3591.54.camel@desktop.cunninghams>
	 <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de>
	 <20040927141652.GF28865@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096323761.3606.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 28 Sep 2004 08:22:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-09-28 at 00:16, Andrea Arcangeli wrote: 
> On Mon, Sep 27, 2004 at 08:16:43AM +0200, Stefan Seyfried wrote:
> > Andrea Arcangeli wrote:
> > 
> > > random keys are exactly fine, but only for the swap usage on a desktop
> > > machine (the one I mentioned above, where the user will not be asked for
> > > a password), but it's not ok for suspend/resume, suspend/resume needs
> > > a regular password asked to the user both at suspend time and at resume
> > > time.
> > 
> > Why not ask on every boot? (and yes, the passphrase could be stored on a
> > fixed disk location - hashed with a function of sufficient complexity
> > and number of bits, just to warn the user if he does a typo, couldn't
> > it?). If suspend is working, you basically never reboot. So why ask on
> > suspend _and_ resume? This also solves the "suspend on lid close" issue.
> 
> because I never use suspend/resume on my desktop, I never shutdown my
> desktop. I don't see why should I spend time typing a password when
> there's no need to. Every single guy out there will complain at linux
> hanging during boot asking for password before reaching kdm.
> 
> I figured out how to make the swap encryption completely transparent to
> userspace, and even to swap suspend, so I think it's much better than
> having userspace asking the user for a password, or userspace choosing a
> random password.

The public/private key idea makes good sense to me.

> > And a resume is - in the beginning - a boot, so just ask early enough
> > (maybe the bootloader could do this?)
> 
> yes, but the bootloader passes the paramters via /proc/cmdline, and it's
> not nice to show the password in cleartext there.

If this password is only needed when resuming, that's not an issue
because the command line given when resuming will be lost when the
original kernel data is copied back.

> suspend/resume is just unusable for me on the laptop until we fix the
> crypto issues.

There's already compression support. It's simpler to reverse, of course,
but it doesn't help?

Regards,

Nigel

