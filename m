Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319361AbSHQFqC>; Sat, 17 Aug 2002 01:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319362AbSHQFqC>; Sat, 17 Aug 2002 01:46:02 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:17362 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S319361AbSHQFqC>; Sat, 17 Aug 2002 01:46:02 -0400
Date: Fri, 16 Aug 2002 22:49:50 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: dhinds <dhinds@sonic.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020816224950.A17930@lucon.org>
References: <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org> <20020816194825.A7086@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816194825.A7086@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Aug 16, 2002 at 07:48:25PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 07:48:25PM +0400, Ivan Kokshaysky wrote:
> On Mon, Aug 12, 2002 at 08:29:42PM -0700, H. J. Lu wrote:
> > I was told all PCI_CLASS_BRIDGE_PCI bridges were transparent. The non-
> > transparent ones have class code PCI_CLASS_BRIDGE_OTHER. This new patch
> > only checks PCI_CLASS_BRIDGE_PCI and works for me.
> 
> I guess that info came from Intel ;-)  Interesting, but completely wrong.
> The devices they call "non-transparent PCI-to-PCI bridges" aren't classic
> PCI-to-PCI bridges at all, that's why they are PCI_CLASS_BRIDGE_OTHER.
> It's more to do with CPU-to-CPU bridges.
> In our terms, "transparent" PCI-to-PCI bridge means subtractive decoding one.
> Your previous patch makes much more sense, although a) it should belong to
> generic pci code b) is way incomplete.
> 
> Please try this one instead.
> 

CardBus works now. But I can no longer load usb-uhci. My X server no
longer works. Your patch is not right.


H.J.
