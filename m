Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSJZXaQ>; Sat, 26 Oct 2002 19:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJZXaQ>; Sat, 26 Oct 2002 19:30:16 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:53909 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S261740AbSJZXaP>; Sat, 26 Oct 2002 19:30:15 -0400
Date: Sat, 26 Oct 2002 19:36:32 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, <jung-ik.lee@intel.com>,
       <tony.luck@intel.com>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
       <linux-ia64@linuxia64.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
In-Reply-To: <20021025232550.B25082@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210261924240.20583-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2002, Russell King wrote:

> On Fri, Oct 25, 2002 at 06:02:31PM -0400, Scott Murray wrote:
> > Unfortunately, my take on the scheme used to reserve space for CardBus
> > bridges was that it only works on platforms that use the setup-*.c code
> > to do their complete PCI subsystem initialization.  On platforms like
> > x86, where the BIOS configures all the devices, something like my patch
> > is needed to fixup things to handle the desired reservation.  I'm not
> > finished getting things ported to 2.5 yet, I'll post a patch ASAP once
> > I've got everything workin.  If you're keen on devising an alternative
> > method, check put my old patch against 2.4.19 at:
>
> I've been working on this in 2.5 this week - I've got something working,
> Alan's happy with the concept as far as the resource allocation goes.
>
> The cardbus reservation method is actually flawed in setup-*.c if you
> want to get rid of the stuff in yenta.c - again, I've fixed this lot
> in my 2.5 tree already, and the patch is pending an update to the x86
> code to do what yenta.c was doing (only setup bridge resources of the
> ones already programmed are bad/wrong.)

This sounds like it could remove the need for my manually specified
resource reservation scheme, does your code currently support arbitrary
bridges, i.e. non-CardBus?

Thanks,

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

