Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSHQPcO>; Sat, 17 Aug 2002 11:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSHQPcO>; Sat, 17 Aug 2002 11:32:14 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:23550 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S311025AbSHQPcN>; Sat, 17 Aug 2002 11:32:13 -0400
Date: Sat, 17 Aug 2002 08:36:01 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dhinds <dhinds@sonic.net>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020817083601.A26274@lucon.org>
References: <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org> <20020816194825.A7086@jurassic.park.msu.ru> <20020816224950.A17930@lucon.org> <3D5E6B10.9070106@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5E6B10.9070106@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Aug 17, 2002 at 11:26:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 11:26:08AM -0400, Jeff Garzik wrote:
> H. J. Lu wrote:> On Fri, Aug 16, 2002 at 07:48:25PM +0400, Ivan 
> Kokshaysky wrote:
> > 
> >>On Mon, Aug 12, 2002 at 08:29:42PM -0700, H. J. Lu wrote:
> >>
> >>>I was told all PCI_CLASS_BRIDGE_PCI bridges were transparent. The non-
> >>>transparent ones have class code PCI_CLASS_BRIDGE_OTHER. This new patch
> >>>only checks PCI_CLASS_BRIDGE_PCI and works for me.
> >>
> >>I guess that info came from Intel ;-)  Interesting, but completely wrong.
> >>The devices they call "non-transparent PCI-to-PCI bridges" aren't classic
> >>PCI-to-PCI bridges at all, that's why they are PCI_CLASS_BRIDGE_OTHER.
> >>It's more to do with CPU-to-CPU bridges.
> >>In our terms, "transparent" PCI-to-PCI bridge means subtractive decoding one.
> >>Your previous patch makes much more sense, although a) it should belong to
> >>generic pci code b) is way incomplete.
> >>
> >>Please try this one instead.
> >>
> > 
> > 
> > CardBus works now. But I can no longer load usb-uhci. My X server no
> > longer works. Your patch is not right.
> 
> 
> I would be willing to bet there is some silliness in the X server, at 
> least.  It's PCI code has always left a lot to be desired...
> 

It could be. But I doubt it. At least, I don't think you can treat a
AGP bridge like a 82801BAM/CAM bridge. I think 82801BAM/CAM is a
special case. You really have to read the datasheet to know for sure.


H.J.
