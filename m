Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSJYV4Z>; Fri, 25 Oct 2002 17:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSJYV4Z>; Fri, 25 Oct 2002 17:56:25 -0400
Received: from [63.204.6.12] ([63.204.6.12]:50862 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S261622AbSJYV4U>;
	Fri, 25 Oct 2002 17:56:20 -0400
Date: Fri, 25 Oct 2002 18:02:31 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, <jung-ik.lee@intel.com>,
       <tony.luck@intel.com>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
       <linux-ia64@linuxia64.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
In-Reply-To: <20021025193725.A3300@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0210251754290.17433-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2002, Ivan Kokshaysky wrote:

> On Thu, Oct 24, 2002 at 06:22:44PM -0400, Scott Murray wrote:
> > I hopefully will have something working against 2.5.44 tomorrow.  I think
> > the only potentially contentious piece that I'd like to get reviewed and
> > maybe integrated before the feature freeze is the resource reservation
> > stuff.  There seemed to be no serious objections to the 2.4.x version I
> > posted a while back, so maybe this won't be a big deal.  Everything else
> > is either __devinit/export tweaks or driver code.
>
> The setup-bus code already does resource reservation, but only for
> cardbus. It can be easily extended for any type of hotplug
> controller though. Other enhancements (like configurable amount
> of reserved IO/memory) also shouldn't be a problem.

Unfortunately, my take on the scheme used to reserve space for CardBus
bridges was that it only works on platforms that use the setup-*.c code
to do their complete PCI subsystem initialization.  On platforms like
x86, where the BIOS configures all the devices, something like my patch
is needed to fixup things to handle the desired reservation.  I'm not
finished getting things ported to 2.5 yet, I'll post a patch ASAP once
I've got everything workin.  If you're keen on devising an alternative
method, check put my old patch against 2.4.19 at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102866931731553&w=2

[snip]
> BTW, 2.5 setup-* stuff went into 2.4 recently. :-)

Cool, that definitely will make my life easier.

Thanks,

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

