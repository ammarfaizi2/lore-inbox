Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTH1WqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTH1WqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:46:08 -0400
Received: from aneto.able.es ([212.97.163.22]:20694 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264315AbTH1WqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:46:02 -0400
Date: Fri, 29 Aug 2003 00:45:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Bryan O'Sullivan" <bos@keyresearch.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting plugged in and out
Message-ID: <20030828224553.GC23528@werewolf.able.es>
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com> <20030828215417.GA22215@werewolf.able.es> <3F4E8373.1040204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F4E8373.1040204@pobox.com>; from jgarzik@pobox.com on Fri, Aug 29, 2003 at 00:34:27 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.29, Jeff Garzik wrote:
> J.A. Magallon wrote:
> > On 08.28, Bryan O'Sullivan wrote:
> > 
> >>Netplug is a daemon that responds to network cables being plugged in or
> >>out by bringing a network interface up or down.  This is extremely
> >>useful for DHCP-managed systems that move around a lot, such as laptops
> >>and systems in cluster environments.
> >>
> >>For more details and download instructions, see the netplug homepage:
> >>http://www.red-bean.com/~bos/
> >>
> > 
> > 
> > I feel sorry, but did you ever knew this existed ?
> > 
> > http://www.stud.uni-hamburg.de/users/lennart/projects/ifplugd/
> 
> 
> ifplugd doesn't appear to use netlink.  Did I miss something?
> 
> netlink is definitely the preferred way to get link notification.  Maybe 
> the two authors can work together to merge the best parts of both...
> 

That would be very nice, but there is still a problem.
Does netlink solve the fact that there are cards (at least in 2.4)
that do not support any detection method:

ne2k-pci
    SIOCETHTOOL failed (Operation not permitted)
    SIOCGMIIPHY failed (Operation not permitted)
    SIOCDEVPRIVATE failed (Operation not supported)

3c59x (3c980-TX)
    SIOCETHTOOL failed (Operation not permitted)
    SIOCGMIIPHY failed (Operation not permitted)
    SIOCDEVPRIVATE: unplugged

3c59x (3c905C-TX/TX-M)
    SIOCETHTOOL failed (Operation not supported)
    SIOCGMIIPHY: link beat detected
    SIOCDEVPRIVATE: link beat detected
 
e100
    SIOCETHTOOL: link beat detected
    SIOCGMIIPHY: link beat detected
    SIOCDEVPRIVATE failed (Operation not supported)

e1000
    SIOCETHTOOL: link beat detected
    SIOCGMIIPHY: link beat detected
    SIOCDEVPRIVATE failed (Operation not supported)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
