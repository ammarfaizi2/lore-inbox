Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUAGNi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUAGNi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:38:26 -0500
Received: from mail.enyo.de ([212.9.189.167]:54027 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S265550AbUAGNiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:38:23 -0500
Date: Wed, 7 Jan 2004 14:39:52 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6.0] autonegotiation broken with 3c905C
Message-ID: <20040107133952.GA1877@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 2.6.0 (and earler -test versions), the card is stuck in
10-BaseT half-duplex mode, at least according to mii-tool.  The abysmal
TCP performance for bulk transfers *from* that host suggests that it's
true. 8-(

Boot messages are:

kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
kernel: 0000:00:08.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.19

"lspci -v" shows the following output:

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 30)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000 [size=128]
        Memory at e3000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

Any suggestions?

(The card is fine with 2.4.21.)
