Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbSIXUu1>; Tue, 24 Sep 2002 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbSIXUu0>; Tue, 24 Sep 2002 16:50:26 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:24546 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S261793AbSIXUuX>; Tue, 24 Sep 2002 16:50:23 -0400
Message-ID: <3D90D0FB.1070805@sun.com>
Date: Tue, 24 Sep 2002 13:54:19 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com> <3D90C4FE.3070909@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> In existing drivers that call netif_carrier_{on,off}, it is perhaps even 
> possible to have them send netlink messages with no driver-specific code 
> changes at all.

This is something that I have been asked to look at, here.  Jeff, how 
(or is?) any of the netlink info pushed up to userspace?  The idea that 
someone came to me with was to have something in (driverfs? netdevfs?) 
that was poll()able and read()able.  read() giving current state, and 
poll() waking on changes.  Or maybe two different files, but something. 
  Of course it'd be greate to be generic.  I just assumed it would come 
from netif_* for netdevices.

Is this something planned?  wanted?  something I should bang out into 
2.5.x before end of next month?

We could have a generic device-events file (akin to acpi events) that a 
daemon dispatches events into user-land, or we could have a kernel->user 
callback a la /sbin/hotplug, or we could have many device/subsys 
specific files.

Anyone have a preference?

Tim



-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

