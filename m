Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUDETYu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUDETYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:24:50 -0400
Received: from smtp.mailix.net ([216.148.213.132]:29507 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263151AbUDETYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:24:48 -0400
Date: Mon, 5 Apr 2004 21:24:43 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040405192443.GA1305@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: 2.6.5: Solid freeze after removing a bluetooth usb dongle
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.221.58 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.221.58 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.221.58 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.221.58 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BAZiC-00079G-LJ)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel freezes after removing the dongle. There were hcitool running
on the interface connected to the usb port.

After modprobing hci-usb, I insert the dongle in the usb port
of the card reader. Than I run "hciconfig hci0 up" to initialize
the interface and start "hcitool scan". While it was running, I
removed the dongle. The computer froze. Nothing in logs, no network.
Hcitool managed to write some error (sorry, can't remember, will try to
reproduce) before everything died.
The scan hasn't found any devices yet. It didn't reported them, anyway, and
there were none active, afaik.

It is the Gentoo Experimental, running on P4-2.6GHz with active SMT,
preemptible is on.
The motherboard has some i865 chipset. USB uses uhci-hcd, bluetooth is
hci-usb. The dongle was inserted in the free port of an usb2-compatible
hub/card reader.
Hcitool is from bluez-utils 2.5, xfree also was running, mouse froze.
The dongle works with a nokia7650 phone (it connects and exchanges some
data, at least) otherwise.
I do not really know what kind of usb/bluetooth this dongle is. Just a
small square blue thing with a green led in a corner.


-alex

