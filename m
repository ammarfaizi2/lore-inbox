Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUBSQrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUBSQrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:47:17 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:47595 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S267365AbUBSQrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:47:10 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2004 16:47:08 -0000
MIME-Version: 1.0
Subject: 2.6.3 RT8139too NIC problems
Message-ID: <4034E88C.24740.4C5D4B6@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Due to traffic restraints, I am not on the lkml - please CC replies.

Yesterday I built 2.6.3.  Clean build, and system runs nice.

I have two NIC's in the box, both rt8139.

But I noticed I am getting this in syslogs:

Linux233 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Linux233 kernel: eth1: link up, 10Mbps, half-duplex, lpa 0x0000
Linux233 kernel: nfs: server 486Linux not responding, still trying
Linux233 kernel: nfs: server 486Linux not responding, still trying
Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Linux233 kernel: nfs: server 486Linux OK
Linux233 kernel: nfs: server 486Linux OK
Linux233 kernel: nfs: server 486Linux not responding, still trying
Linux233 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Linux233 kernel: nfs: server 486Linux OK

This happens about once every 3 hours.

>From my config file:

# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_8139_RXBUF_IDX= is not set

No other NIC drivers are used.

I am also stuck as to what the new RXBUF_IDX is for.  It appears the 
new build needs it, as I cannot remove.

These cards have worked fine under all 2.4.x and 2.6.1/2.6.2 kernels.

Ideas?

TIA,

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

