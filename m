Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTGAVuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTGAVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:50:35 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:27614
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263997AbTGAVud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:50:33 -0400
Date: Tue, 1 Jul 2003 18:04:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdevoss.sgi.com@gtf.org
Subject: [BK PATCHES] 2.5.x net driver merges
Message-ID: <20030701220456.GA27122@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(testing new email address)

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.73-bk9-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/e100/e100_main.c      |    3 
 drivers/net/tulip/de2104x.c       |    1 
 drivers/net/typhoon.c             |   10 +-
 drivers/net/wireless/airo.c       |   24 ++---
 drivers/net/wireless/netwave_cs.c |   32 +++----
 drivers/net/wireless/strip.c      |  169 ++++++++++++++++++++------------------
 6 files changed, 121 insertions(+), 118 deletions(-)

through these ChangeSets:

<mzyngier@freesurf.fr> (03/07/01 1.1522)
   [netdrvr de2104x] quiet link timer
   
   (can be enabled by ethtool)

<gandalf@wlug.westbo.se> (03/06/27 1.1521)
   [PATCH] fix use-after-free in e100

<daniel.ritz@gmx.ch> (03/06/27 1.1520)
   [PATCH] alloc_etherdev for netwave_cs.c
   
   erm...i didn't actually compile it...
   sorry. corrected patch below.
   
   -daniel
   
   On Fri June 27 2003 00:45, Daniel Ritz wrote:
   > cleans up netwave_cs.c to use alloc_etherdev instead of allocating the
   > device out of the private data structure. compile tested only.
   > against 2.5.73-bk

<daniel.ritz@gmx.ch> (03/06/27 1.1519)
   [PATCH] strip.c: don't allocate net_device as part of private struct
   
   hi jeff
   
   cleans up strip.c not to allocate struct net_device as part of the private
   structure. use a separate kmalloc (and kfree). compile tested only.
   against 2.5.73-bk
   
   -daniel

<daniel.ritz@gmx.ch> (03/06/27 1.1518)
   [PATCH] module ref counting for airo.c
   
   clean up airo.c: remove MOD_(INC|DEC)_USE_COUNT, set the owner field instead.
   compile tested only. against 2.5.73-bk

<dave@thedillows.org> (03/06/27 1.1348.28.1)
   Fix misreporting of card type and spurious "already scheduled" messages.

<dave@thedillows.org> (03/02/22 1.889.238.1)
   Use a non-zero rx_copybreak to avoid charging a full MTU to the
   socket on tiny packets.
   
   Dave Miller suggested 256, I used 200 to be more consistent with the
   other network drivers.

