Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271095AbRHYGzn>; Sat, 25 Aug 2001 02:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271105AbRHYGzd>; Sat, 25 Aug 2001 02:55:33 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:18105 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271095AbRHYGzZ>;
	Sat, 25 Aug 2001 02:55:25 -0400
Message-ID: <3B874BED.E641DB96@candelatech.com>
Date: Fri, 24 Aug 2001 23:55:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: VIA Rhine problem in 2.4.9-pre4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seem that my built-in ethernet NIC has either gone bad, or the
2.4.9-pre4 drivers are bad.  It only seems to happen with this one machine,
so it could be hardware.  The symptom is that the NIC looses the ability
to transmit.  It does receive pkts OK (ie it received an ARP request from
my other machine, and answered according to tcpdump, but the pkt was
never put on the wire it seems.

Here is a snippet of the dmesg:

eth0: VIA VT2043 Rhine at 0xe000, 00:50:08:00:35:c6, IRQ 11.
eth0:  MII PHY found at address 1, status 0x782d advertising 05e1 Link 0021

This last time it happened, I noticed this printed to the console:

eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x9 length 0 status 00000600
eth0:  Oversized Ethernet frame c7572090 vs c7572090.


I looked at /proc/net/dev and didn't see too many errors (there were a few, though,
including carrier errors).  I tried replacing the cable but that did not fix
the problem.  The link does come back up after reboot...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
