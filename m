Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271177AbTHCNe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 09:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbTHCNe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 09:34:56 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:32408 "EHLO
	uptime.churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S271177AbTHCNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 09:34:54 -0400
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad
	value compared to 2.4
From: Stefan Jones <cretin@gentoo.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <20030803135033.A15221@flint.arm.linux.org.uk>
References: <1059244318.3400.17.camel@localhost>
	 <20030802180837.B1895@flint.arm.linux.org.uk>
	 <1059908861.3424.7.camel@localhost>
	 <20030803135033.A15221@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Gentoo Linux
Message-Id: <1059917686.3425.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 14:34:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 13:50, Russell King wrote:

> 
> Hmm, so it looks like the hardware didn't report an insert event.  Can you
> add a couple of printk()'s to yenta_events() to display the values of
> cb_event and csc please?

using 

printk(KERN_DEBUG"yenta_events: csc= %04x cb_event= %04x\n",csc,cb_event);
in yenta_events

I get, 

Stefan

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
yenta_events: csc= 0000 cb_event= 0001
yenta_events: csc= 0000 cb_event= 0001
yenta_events: csc= 0000 cb_event= 0001
yenta_events: csc= 0000 cb_event= 0001
yenta_events: csc= 0000 cb_event= 0001
Yenta IRQ list 0038, PCI irq11
Socket status: 30000417
parse_events: socket d56afc2c thread ce4db3c0 events 00000080
yenta_get_status: status=30000417
socket d56afc2c status 00000041
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2c8-0x2cf 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: status=30000417

[ Still nothing on first insertion ]

yenta_events: csc= 0000 cb_event= 0006
parse_events: socket d56afc2c thread ce4db3c0 events 00000080
yenta_get_status: status=30000417
socket d56afc2c status 00000041
yenta_events: csc= 0000 cb_event= 0006
parse_events: socket d56afc2c thread ce4db3c0 events 00000080
yenta_get_status: status=30000411
socket d56afc2c status 000000c1
socket_insert: skt d56afc2c
yenta_get_status: status=30000411
socket_setup: skt d56afc2c status 000000c1
yenta_get_status: status=30000411
socket_reset: skt d56afc2c
yenta_get_status: status=30000419
yenta_get_status: status=30000419
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.3.6
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:09:5B:4A:B1:B6
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
yenta_events: csc= 0000 cb_event= 0000
[ repeated many times ..... ]


