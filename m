Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293657AbSCATML>; Fri, 1 Mar 2002 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCATLE>; Fri, 1 Mar 2002 14:11:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21513 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293640AbSCATJ2>;
	Fri, 1 Mar 2002 14:09:28 -0500
Message-ID: <3C7FD1E3.800A61FD@mandrakesoft.com>
Date: Fri, 01 Mar 2002 14:09:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com> <20020301174619.A6125@devcon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> The 3c59x one is available on
> http://www.myipv6.de/patches/vlan/3c59x.c-8021q.patch

Comments:

1) This patch is (like I mentioned earlier) for reference only, not for
application.  It is really halfway in between software and hardware VLAN
support.

2) You don't want to set_8021q_mode if VLAN is not active.  It's silly
to activate it when VLAN is compiled as a module but no one is using
vlans.  That's going to be THE common case, because distros will
inevitably build the VLAN module with their stock kernel.

3) 3c59x needs real dev->change_mtu support.  This patch provides the
info needed to do that... but doesn't do that.

4) It uses magic numbers instead of ETH_DATA_LEN and ETH_HLEN

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
