Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbRFSWLt>; Tue, 19 Jun 2001 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbRFSWLj>; Tue, 19 Jun 2001 18:11:39 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:17860 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264810AbRFSWL2>;
	Tue, 19 Jun 2001 18:11:28 -0400
Message-ID: <3B2FCE0C.67715139@candelatech.com>
Date: Tue, 19 Jun 2001 15:11:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Holger Kiehl <Holger.Kiehl@dwd.de>, "David S. Miller" <davem@redhat.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Should VLANs be devices or something else?
In-Reply-To: <Pine.LNX.4.30.0106191016200.27487-100000@talentix.dwd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had a good discussion with Dave Miller today, and there
is one outstanding issue to clear up before my 802.1Q VLAN patch may
be considered for acceptance into the kernel:

Should VLANs be devices or some other thing?

I strongly feel that they should be devices for many reasons.

1)  It makes integration with user-space tools (ip, ifconfig, arp...) a non-issue.

2)  It is logically correct, a VLAN is a (net_)device and in all ways acts like one.

3)  It introduces no fast-path performance degradation that I know of.  The one
    slow path involves the linear lookup of a device by name (or id??).  This can
    be fixed by hashing the list, if needed.

4)  Both VLAN patches have used VLANs-as-devices from the beginning, and have
    seen no ill affects to this approach that would be mitigated by some other
    architecture.

However, we need the community as a whole to agree more-or-less that my
(and others who share them) arguments are sound.  So please, bring your
complaints fowards now...or forever patch by hand!

Also, any other complaints or suggestions for the VLAN code should be
mentioned too, of course!

If you wish to view the patch, get the 1.0.1 release from my vlan page:
http://scry.wanfear.com/~greear/vlan.html
I will release a new one shortly with the fast-dev-lookup code
(which is already #ifdef'd out) completely removed, as per Dave's
wish.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
