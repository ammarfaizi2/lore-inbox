Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTDZEGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 00:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTDZEF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 00:05:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264608AbTDZEFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 00:05:24 -0400
Message-ID: <3EAA0855.5080906@pobox.com>
Date: Sat, 26 Apr 2003 00:17:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver merges
Content-Type: multipart/mixed;
 boundary="------------030301040901060309060004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030301040901060309060004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

More coming this weekend, Andrew's irqreturn_t fixes for net drivers 
being top on the list.

--------------030301040901060309060004
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/sundance.c      |  101 ++++++++++++++++++++++++++------------------
 drivers/net/tg3.c           |    6 ++
 drivers/net/typhoon.c       |    4 -
 drivers/net/via-rhine.c     |    2 
 drivers/net/wireless/airo.c |    2 
 5 files changed, 71 insertions(+), 44 deletions(-)

through these ChangeSets:

<Valdis.Kletnieks@vt.edu> (03/04/26 1.1223)
   [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

<edward_peng@dlink.com.tw> (03/04/25 1.1222)
   [netdrvr sundance] bug fixes, VLAN support
   
       - Fix tx bugs in big-endian machines
       - Remove unused max_interrupt_work module parameter, the new 
         NAPI-like rx scheme doesn't need it.
       - Remove redundancy get_stats() in intr_handler(), those 
         I/O access could affect performance in ARM-based system
       - Add Linux software VLAN support
       - Fix bug of custom mac address 
       (StationAddr register only accept word write) 

<edward_peng@dlink.com.tw> (03/04/25 1.1221)
   [netdrvr via-rhine] fix promisc mode
   
   I found a via-rhine bug, it can't receive BPDU (mac: 0180c2000000)
   in promiscuous mode. 
   Fill all "1" in hash table to fix this problem in promiscuous mode.
   (RCR remain 0x1c, write it as 0x1f don't work)

<riel@redhat.com> (03/04/25 1.1220)
   [wireless airo] make end-of-array test more portable
   
   FYI statsLabels[] is an array of char*, so the fix below
   is pretty obvious.

<jgarzik@redhat.com> (03/04/23 1.1218)
   [netdrvr tg3] fix omission in board shutdown sequence

<jgarzik@redhat.com> (03/04/23 1.1186.1.1)
   [netdrvr tg3] detect shared (and screaming) interrupts


--------------030301040901060309060004--

