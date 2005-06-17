Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVFQT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVFQT1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVFQT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:27:37 -0400
Received: from waste.org ([216.27.176.166]:59074 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262067AbVFQT1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:27:24 -0400
Date: Fri, 17 Jun 2005 12:27:15 -0700
From: Matt Mackall <mpm@selenic.com>
To: David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: usbnet ethernet duplex issue?
Message-ID: <20050617192715.GK27572@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with a Netgear FA-120 USB 2.0 to Ethernet device and
seeing some strange behavior.

If I run a 100MB transfer (TCP, via nc and dd) over out LAN, with the
Netgear on the sending end, I get about 10MB/s, as expected.
Receiving, I get ~5MB/s. If I do simultaneous send and receive, the
throughput is a few K per second at best.

If I do the same transfers between a pair of isolated laptops, with
the Netgear on one end and Intel e100 or e1000 on the other, I see about
500-900K per second in either direction.

There are no errors detected by the usbnet driver and ethtool reports
that the device is autonegotiating, full duplex. Setting autoneg off
and duplex to half lets the isolated transfers go at wirespeed.

So the question is, what's up with duplex? Everything I can find about
the hardware (including the ASIX datasheet) claims it's full-duplex
capable but aside from the error counters, it's really behaving like a
half-duplex device.

-- 
Mathematics is the supreme nostalgia of our time.
