Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUDTBMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUDTBMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 21:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDTBMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 21:12:03 -0400
Received: from mail07c.vwh1.net ([207.201.152.68]:55335 "HELO mail07c.vwh1.net")
	by vger.kernel.org with SMTP id S262052AbUDTBMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 21:12:00 -0400
From: Nick Popoff <cryptic-lkml@bloodletting.com>
To: linux-kernel@vger.kernel.org
Subject: Testing Dual Ethernet via Loopback
Date: Mon, 19 Apr 2004 06:14:21 -0700
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404190614.21764.cryptic-lkml@bloodletting.com>
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am trying to write some software to test a dual port ethernet card.  I
was hoping to be able to use an ethernet cable to just connect the
ethernet board to itself and then write a program that talks to itself to
make sure that both ports are working.  However, I've noticed that Linux
is smart enough to realize it is talking to its own IP address, and it
just delivers the data internally rather than use the network hardware at
all.

So what I'm wondering is if there is a way to force Linux to actually
utilize its network hardware in sending these packets to itself?  In other
words, a ping or file transfer from an IP assigned to eth0 to another IP
assigned to eth1 should fail if I unplug the network cable connecting the
two.  Any advice on this would be much appreciated.  I'm not afraid of
reading kernel source but have no idea where to start on this one.

I'm using 2.4.22 but would use any 2.4 or 2.6 kernel that supported this
behavior. The National Semiconductor DP83815 (natsemi.o) is the 
ethernet chipset.


