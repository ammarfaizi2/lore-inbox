Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131027AbQLJN3X>; Sun, 10 Dec 2000 08:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbQLJN3O>; Sun, 10 Dec 2000 08:29:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15633 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131027AbQLJN3A>;
	Sun, 10 Dec 2000 08:29:00 -0500
Message-ID: <3A337DF1.DD9516C7@mandrakesoft.com>
Date: Sun, 10 Dec 2000 07:58:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>,
        "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: hotplug mopup
In-Reply-To: <3A3377B3.FDCBE4AD@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - On the unregister/removal path, the netdevice layer ensures that
>   the interface is removed from the kernel namespace prior to launching
>   `/sbin/hotplug net unregister eth0'.
> 
>   This means that when handling netdevice unregistration
>   /sbin/hotplug cannot and must not attempt to do anything with eth0!
>   Generally it'll fail to find an interface with this name.  If it does
>   find eth0, it'll be the wrong one due to a race.

This is not a bug.  'unregister eth0' says to userspace "eth0 just
disappeared."

Read my previous messages on the subject:  Add events like NETDEV_UP,
NETDEV_DOWN, and NETDEV_GOING_DOWN to netdev_event_names[] if you want
to call /sbin/hotplug for other netdev events.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
