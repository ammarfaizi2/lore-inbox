Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbREOX7C>; Tue, 15 May 2001 19:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261720AbREOX6w>; Tue, 15 May 2001 19:58:52 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:28679 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S261716AbREOX6m>;
	Tue, 15 May 2001 19:58:42 -0400
To: <linux-kernel@vger.kernel.org>
Cc: "Daniela P. R. Magri Squassoni" <daniela@cyclades.com>
Subject: New generic HDLC available
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 16 May 2001 01:28:28 +0200
Message-ID: <m3bsoumbtv.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've put new experimental version of my generic HDLC code on
http://hq.pm.waw.pl/hdlc/ ( ftp://ftp.pm.waw.pl/pub/linux/hdlc/experimental/ )

Currently supported (hw drivers) are C101 and N2 (untested) boards.
Protocols supported:
- X.25 and PPP (via X.25 and syncppp routines)
- Frame Relay (CCITT and ANSI LMI, or no LMI)
- Cisco HDLC
- raw HDLC (you can select NRZ/NRZI/Manchester/FM codes and parity)

This version uses new ioctl interface. Comments welcome.

No HDLC/FR bridging code yet. No Cisco LMI support (for FR) yet.
No docs (except Documentation/networking/generic-hdlc.txt) yet.
I'm thinking about implementing asynchronous HDLC driver.

The patch has been generated against 2.4.4-ac6 tree. It should apply to
pure 2.4.4 as well. Protocol support is now split into separate files
hdlc_fr.c, hdlc_cisco.c etc.
-- 
Krzysztof Halasa
Network Administrator
