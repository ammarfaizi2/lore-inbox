Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbRATD1y>; Fri, 19 Jan 2001 22:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRATD1p>; Fri, 19 Jan 2001 22:27:45 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:51204 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129908AbRATD1d>;
	Fri, 19 Jan 2001 22:27:33 -0500
Message-ID: <3A691524.C534BEDE@candelatech.com>
Date: Fri, 19 Jan 2001 21:33:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "gleb@tochna.technion.ac.il" <gleb@tochna.technion.ac.il>
Subject: [PATCH] 802.1Q VLAN for Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing 802.1Q VLAN version 1.0.0 for Linux.

802.1Q VLAN is an industry standard that allows you to run multiple
Virtual LANs over a single ethernet wire/interface.  It also supports
priority settings.  To user-space code, this VLAN patch makes VLAN
devices look like Ethernet devices.

The patch is large, so go here to find it:  (get version 1.0.0)
http://scry.wanfear.com/~greear/vlan.html

Or, if you just want the raw patch & user tools with no explanation:
http://scry.wanfear.com/~greear/vlan/vlan.1.0.0.tar.gz

If you really want the whole thing as a diff emailed to you, let me know!

This code has been in development for about 2 years now, and I feel
it is stable enough to warrant inclusion into the kernel as
an EXPERIMENTAL feature.  I understand Linus and others may not
wish to add it to 2.4.0 proper, but even getting in something
like the -ac series, or any broader audience, should help wring
the final bugs out and ensure it will be stable.  Your comments
and testing will help make the code stronger!

My 802.1Q VLAN patch features:

    * Implements 802.1Q VLAN spec. 
    * Can support up to 4094 VLANs per ethernet interface. 
    * Scales well in critical paths: O(1), as far as I can tell. 
    * Optional hashed device lookup tables in the kernel, for better scalability in non-critical paths. 
    * Supports MULTICAST
    * Can change MAC address of VLAN. 
    * Multiple naming conventions supported, and adjustable at runtime. 
    * Optional header-reordering, to make the VLAN interface look JUST LIKE an Ethernet interface. This
      fixes some problems with DHCPd and anything else that uses a SOCK_PACKET socket. Default
      setting is off, which works for every other protocol I know about, and is slightly faster. 
    * Patches for both the 2.2.X series and the 2.4.0 series.
    * /proc file system support (/proc/net/vlan)
    * 802.1Q Priority mapping and support.
    
I have not tested compiling it in as a module, though preliminary module support
has been added to the 2.4.0 patch.  It should work just fine when compiled
in (not a module.)

For comparison, there is also another VLAN project at
http://vlan.sourceforge.net, but I think mine is better, or
at least has a more colorful web-page! :)


Comments are welcome.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
