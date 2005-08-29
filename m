Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVH2SEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVH2SEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVH2SEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:04:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751188AbVH2SEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:04:23 -0400
Date: Mon, 29 Aug 2005 11:04:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Linux 2.6.12.6
Message-ID: <20050829180418.GZ7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.12.6 kernel.
This is final one for 2.6.12 now that 2.6.13 has been released.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.12.5 and 2.6.12.6, as it is small enough to do so.

The updated 2.6.12.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                    |    2 +-
 drivers/scsi/sg.c           |   15 ++++++++-------
 drivers/usb/net/usbnet.c    |    2 +-
 kernel/signal.c             |    2 +-
 lib/zlib_inflate/inftrees.c |    2 +-
 net/ipv4/icmp.c             |   12 ++++++------
 net/ipv4/ip_sockglue.c      |    3 +++
 net/ipv6/ip6_input.c        |    9 +++++----
 net/ipv6/ipv6_sockglue.c    |    3 +++
 9 files changed, 29 insertions(+), 21 deletions(-)

Summary of changes from v2.6.12.5 to v2.6.12.6
==============================================

Bhavesh P. Davda:
  NPTL signal delivery deadlock fix

Chris Wright:
  Linux 2.6.12.6

Herbert Xu:
  Restrict socket policy loading to CAP_NET_ADMIN - CAN-2005-2555

Jan Blunck:
  sg.c: fix a memory leak in devices seq_file implementation (2nd)

lepton:
  fix gl_skb/skb type error in genelink driver in usbnet

Linus Torvalds:
  Revert unnecessary zlib_inflate/inftrees.c fix

Patrick McHardy:
  Fix DST leak in icmp_push_reply()
  Fix SKB leak in ip6_input_finish()
