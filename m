Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRC3Fop>; Fri, 30 Mar 2001 00:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRC3Fog>; Fri, 30 Mar 2001 00:44:36 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:18274 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130721AbRC3Fo0>; Fri, 30 Mar 2001 00:44:26 -0500
Date: Thu, 29 Mar 2001 23:43:31 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3u24c6cf7.fsf@intrepid.pm.waw.pl>
Message-ID: <Pine.LNX.3.96.1010329234142.14911E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Mar 2001, Krzysztof Halasa wrote:

> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> > > Maybe it's a better idea to have just two ioctl's here (GET and SET), and
> > > have "subioctl's" inside the structure passed to the HDLC layer (and
> > > defined by the HDLC layer). This would allow changes in the HDLC layer
> > > without having to change sockios.h (you'd still have to change HDLC's
> > > code and definitions, but this would be more self-contained). Again, this
> > > may be better, or maybe not. What do you think?
> > 
> > That's essentially what's happening with ethtool
> > (include/linux/ethtool.h in 2.4.3-pre8)
> 
> Right. While I don't think ethernet-only interface is our ultimate goal,
> I'll look at it again to see if I can stole some idea there.

I'm not suggesting you modify ethtool for your needs :)   But ethtool
perfectly illustrates the technique of using a single socket ioctl
(SIOCETHTOOL) to extend a set of standard, domain-specific ioctls
(ETHTOOL_xxx) to Linux networking drivers.

	Jeff



