Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSIXXiv>; Tue, 24 Sep 2002 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSIXXiu>; Tue, 24 Sep 2002 19:38:50 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:14311 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261786AbSIXXiu>; Tue, 24 Sep 2002 19:38:50 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: alternate event logging proposal
Date: Wed, 25 Sep 2002 09:37:20 +1000
User-Agent: KMail/1.4.5
Cc: Tim Hockin <thockin@sun.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>
References: <20020924073051.363D92C1A7@lists.samba.org> <200209250832.35068.bhards@bigpond.net.au> <3D90F5D3.4070504@pobox.com>
In-Reply-To: <3D90F5D3.4070504@pobox.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209250937.20887.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 25 Sep 2002 09:31, Jeff Garzik wrote:
> Brad Hards wrote:
> > I liked the /sbin/hotplug arrangement (aka call_usermode_helper). In
> > fact, my plan was to add the call_usermode_helper call to the
> > netif_carrier_[on,off] functions. Unfortuantely, I've been to too many of
> > Rusty's talks, and know that calling a function that is only safe in user
> > context is unlikely to be a good idea in netif_carrier_[on,off], which
> > are more than likely running in interrupt context.
>
> You really want something where a userspace app can sleep on an fd, to
> be awakened when link changes (or some other interesting event occurs)
Maybe - I've been thinking of a "hotplug" daemon, that can take notifications 
from the kernel _and_ from other userspace apps. The integrated solution 
somehow needs to incorporate device hotplugging (eg USB, PCI), network device 
events (netlink), userspace reconfiguration (eg X colour depth and 
resolution) and maybe network infrastructure (external to the machine, 
probably SLPv2 or similar), and reconfigure kernel and applications to match.

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Aust. Tickets booked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE9kPcwW6pHgIdAuOMRAoaDAJ9PnK962eJCuKdobU64SfY/2SRemQCYxSUS
CfTiTN9hOq+gfldzcgDzCQ==
=bDjx
-----END PGP SIGNATURE-----

