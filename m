Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUBWWD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUBWWD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:03:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:49801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262028AbUBWWDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:03:25 -0500
Date: Mon, 23 Feb 2004 14:08:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: riel@redhat.com, herbert@13thfloor.at, mikpe@csd.uu.se,
       linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <20040223134853.5947a414.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org> <20040223134853.5947a414.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, David S. Miller wrote:
> 
> You mean the PCI controller is in the CPU, else how else would you
> accomplish this?

The IOMMU basically needs to be on the northbridge or at least in between
the PCI bus an a northbridge (pretty much by definition: the bridge
between IO and memory). On an Opteron, that's on-the-chip. For current
Intel chips that's a separate chip.

In fact, I _think_ you could actually use the AGP bridge as a strange
IOMMU. Of course, right now their AGP bridges are all 32-bit limited
anyway, but the point being that they at least in theory would seem to
have the capability to do this.

> Really, not having an IOMMU on a 64-bit platform these days is basically like
> pulling out one's toenails with an ice pick.

Well, as long as they had that "64-bit is server" mentality, they can 
honestly say that you just have to use 64-bit-capable PCI cards.

Now, the "server only" mentality is obviously crap, but since we haven't
even seen the chipsets designed for the 64-bit chips, we shouldn't
complain. At least yet.

Now, I'm not above complaining about Intel (in fact, the Intel people seem
to often think I hate them because I'm apparently the only person who gets
quoted who complains about bad decisions publicly), but at least I try to
avoid complaining before-the-fact ;)

			Linus
