Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCKQlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCKQlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCKQld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:41:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32973 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261197AbVCKQj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:39:59 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: AGP bogosities
Date: Fri, 11 Mar 2005 08:39:15 -0800
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503102002.47645.jbarnes@engr.sgi.com> <1110515459.32556.346.camel@gaston>
In-Reply-To: <1110515459.32556.346.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503110839.15995.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 10, 2005 8:30 pm, Benjamin Herrenschmidt wrote:
> On Thu, 2005-03-10 at 20:02 -0800, Jesse Barnes wrote:
> > On Thursday, March 10, 2005 6:38 pm, Benjamin Herrenschmidt wrote:
> > > That one is even worse... from what I see in your lspci output, you
> > > have no bridge with AGP capability at all, and the various AGP devices
> > > are all siblings...
> >
> > Both of the video cards are sitting on agp busses in agp slots hooked up
> > to host to agp bridges.
> >
> > > Are you sure there is any real AGP slot in there ?
> >
> > Yes :)
>
> Well, according to your lspci, none of the bridges exposes a device with
> AGP capabilities...

There are no bridges listed in my lspci output, that's probably why. :)

> It looks like you aren't exposing the host "self" 
> device on the bus. Do you have an AGP driver ? If yes, it certainly
> can't use any of the generic code anyway ...

Right, it's a special agp driver, sgi-agp.c.

> I still think that the matching between a bridge and a card should be a
> bridge callback (with eventually a generic one that works for whatever
> x86 are around) so that the bridge driver can deal with funky layouts. I
> have no time to toy with this at the moment though ;)

Mike, does this sound ok?  Maybe you could hack something together?

Thanks,
Jesse
