Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTDGN0A (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTDGN0A (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:26:00 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:24035 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263422AbTDGN0A (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:26:00 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.4.21pre7, 2.4.21pre5ac3, 2.5.66 generic HDLC update
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 07 Apr 2003 15:36:51 +0200
Message-ID: <m31y0e8m4s.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The last update to generic HDLC is here:
ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre7-1.14.patch
ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.4.21pre5-ac3-1.14.patch
ftp://ftp.pm.waw.pl/pub/linux/hdlc/hdlc-2.5.66-1.14.patch

This version fixes:
- missing rtnl_lock()/rtnl_unload() bug on unregister_hdlc_device
- N2, C101: interrupt handler now works under high IRQ load from other
  devices (with previous versions, the IRQ processing for the card could
  sometimes stop after reaching "work limit")

This is production-tested on devices I have access to (N2, C101, PC300,
PCI200SYN).
Please apply.
Thanks.

PS. It would be nice to have this code in final 2.4.21. In comparison
to 2.4.21pre7, this version fixes some small bugs and problems (TX packet
latency on HD64570-based boards), and provides support for Ethernet over
HDLC and Frame-Relay, while being API/ABI compatible (use of new features
require new version of user-space sethdlc tool).
-- 
Krzysztof Halasa
Network Administrator
