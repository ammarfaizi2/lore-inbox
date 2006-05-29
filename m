Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWE3C66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWE3C66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWE3C66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:58:58 -0400
Received: from smtp.enter.net ([216.193.128.24]:6419 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932134AbWE3C65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:58:57 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Mon, 29 May 2006 22:58:48 +0000
User-Agent: KMail/1.8.1
Cc: "Jeff Garzik" <jeff@garzik.org>, "Pavel Machek" <pavel@ucw.cz>,
       "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <447B666F.5080109@garzik.org> <9e4733910605291510i18d80ff3qc7be3b412fc99785@mail.gmail.com>
In-Reply-To: <9e4733910605291510i18d80ff3qc7be3b412fc99785@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605292258.49082.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 22:10, Jon Smirl wrote:
> On 5/29/06, Jeff Garzik <jeff@garzik.org> wrote:
> > Pavel Machek wrote:
> > > These are very reasonable rules... but still, I think we need to move
> > > away from vgacon/vesafb. We need proper hardware drivers for our
> > > hardware.
> >
> > I agree we need proper drivers, but moving away from vesafb will be
> > tough... moving away from vgacon is likely impossible for many many
> > years yet.
> >
> > Once proper hardware drivers exist, you will still need to support
> > booting into a situation where you probably need video before a driver
> > can be loaded -- e.g. distro installers.  Server owners will likely
> > prefer vgacon over a huge video driver they will never use for anything
> > but text mode console.
>
> These are areas that definitely need more discussion and design work
> once we can come to some kind of basic agreement on where to start. I
> would definitely like to reduce the number of permutations on how
> video drivers can be combined to an absolute minimum. For example
> vesafb has caused me a number of problems when it is used
> simultaneously with other drivers.
>
> Other areas that can be explored:
> 1) Multiple active consoles on multiple video cards
> 2) User space console driver
> 3) Ownership of video hardware by the logged in user
> 4) Using graphics mode to do console for complex Asian languages
> 5) Concept of a safe mode console that will work in all environments

Not until the framework gets layed, and preferably not unless someone can 
provide a good reason for taking these steps (besides #1 - that is one I 
think has potential. A console set aside for, perhaps, little more that 
keeping a log of error messages.)

DRH
