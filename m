Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130004AbQJLF3U>; Thu, 12 Oct 2000 01:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129125AbQJLF3K>; Thu, 12 Oct 2000 01:29:10 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:17675 "EHLO grok.yi.org") by vger.kernel.org with ESMTP id <S129131AbQJLF26>; Thu, 12 Oct 2000 01:28:58 -0400
Message-ID: <39E55557.9B6C1E6F@candelatech.com>
Date: Wed, 11 Oct 2000 23:08:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: VLAN Mailing List <vlan@Scry.WANfear.com>, linux-net <linux-net@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE:  Linux 802.1Q VLAN 0.0.13 released.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can find the download, and other information at:

http://scry.wanfear.com/~greear/vlan.html

This release seems to work, at least in the limited fashion that
I can test it.  However, don't consider it production code (use 0.0.12
if that is what you want...)

Please try it out, and let me know how it goes.  I'm especially interested
in finding out if the change-mac-address for a VLAN code works, as well as
the ethernet MULTICAST code.

Thanks,
Ben

Changes for this release:

        Added support for MULTICAST to the VLAN devices. Thanks to
        Gleb & Co for most of that code. 
        
        Added the ability to set the MAC address on the VLAN. For now,
        you'll either need to set your Ethernet NIC into PROMISC mode, or
        maybe figure out some multi-cast ethernet address to set on the
        NIC. This has not been tested well at all. 
        
        Added a hashed device-name lookup scheme. This greatly speeds
        up ifconfig -a. I was able to run an ifconfig -a in 20 seconds on a
        Celeron 500, with 4000 vlan devices configured!! 
        
        Added vlan_test.pl to help me find dumb bugs. Feel free to make this
        much more powerful, and send the code back to me! 
        
        vconfig.c has been converted to C code now, instead of C++.
        Thanks to MATHIEU. 
        
        Significantly cleaned up the code w/out decreasing any useful
        functionality, I believe. 

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
