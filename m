Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288976AbSBDNlR>; Mon, 4 Feb 2002 08:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288978AbSBDNlH>; Mon, 4 Feb 2002 08:41:07 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:51091 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S288973AbSBDNlC>;
	Mon, 4 Feb 2002 08:41:02 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
In-Reply-To: <20020202190242.C1740@havoc.gtf.org>
	<E16XAnc-00010K-00@the-village.bc.nu>
	<20020202200332.A3740@havoc.gtf.org>
	<20020203181302.C12963@fafner.intra.cogenit.fr>
	<20020203124614.A10139@havoc.gtf.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 04 Feb 2002 13:46:59 +0100
In-Reply-To: <20020203124614.A10139@havoc.gtf.org>
Message-ID: <m3k7tt5s8s.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> writes:

> "SIOCDEVICE" as a constant is unacceptable, so it would need to be
> SIOCWANDEVICE or something similar.

Well, I was probably under impression it should be used for Ethernet
as well (see the Dec 2000 thread)... Now I think I know people
using Ethernet (with full duplex over SM fibre) for WAN connections
- so SIOCWANDEVICE is ok. Not sure about TR, though - anyone using
it for WAN networking?

> SIOCETHTOOL, for example, is an ioctl which actually provides
> sub-ioctls, so that is probably a good model to follow.

SIOCDEVICE^WSIOCWANDEVICE of course has sub-ioctls as well. It is
obviously impossible without them.


I do _not_ want to fight any ETHTOOL vs SIOCDEVICE etc. battle here.
What I want is creating the best interface for controlling network
devices. Including Token Ring and Ethernet, unless there are valid
reasons to do otherwise.

I think we should concentrate on the interface first, then I will
patch the HDLC implementation.

If we're here... maybe we should really drop using the ifreq structure
and _replace_ it with better one (variable-sized)? It can be done
gradually, as both are quite compatible.
-- 
Krzysztof Halasa
Network Administrator
