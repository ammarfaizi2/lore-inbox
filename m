Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUHVWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUHVWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUHVWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:48:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31944 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267319AbUHVWsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:48:04 -0400
Subject: RE: Cursed Checksums
From: Albert Cahalan <albert@users.sf.net>
To: Josan Kadett <corporate@superonline.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1Bz02y-00052n-3Z@sc8-sf-mx2.sourceforge.net>
References: <E1Bz02y-00052n-3Z@sc8-sf-mx2.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1093205640.5759.3246.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2004 16:14:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 18:38, Josan Kadett wrote:
> In normal conditions, when NAT translates an IP header, it should do correct
> checksumming. However; when the source IP address of a packet is
> manipulated, Iptables still seems to use the "original" IP address and
> calculate the checksum accordingly. This way even if I use 3 three boxes;
> 
> Original Packet --> NAT 1 --> NAT 2 --> NAT3 --> Still incorrect checksum

Sure. That's why I think this is a job for ebtables.
Note: EBtables, not IPtables. This is lower level,
dealing with raw Ethernet packets. It should be able
to mangle anything in the packet.

Just as iptables lets you change any 32-bit value in
an IP packet, ebtables should let you change any 32-bit
value in an Ethernet packet. Unlike iptables, it could
operate prior to the IP checksum verification.

Sadly, it looks like u32 mangle rules are missing.


