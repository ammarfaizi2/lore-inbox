Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKICkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKICkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKICkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:40:11 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:35003 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261356AbUKICj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:39:59 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: BUG: atomic counter underflow when running "rmmod tg3" on 2.6.10-rc1-mm3
Date: Tue, 9 Nov 2004 03:33:36 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411090333.36550.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: atomic counter underflow at:
 [<c02882f6>] qdisc_destroy+0x66/0x80
 [<c02885e2>] dev_shutdown+0x32/0x90
 [<c02d796f>] __down_failed_trylock+0x7/0xc
 [<c027b6b2>] unregister_netdevice+0x142/0x29e
 [<c014c171>] handle_mm_fault+0xf1/0x510
 [<c0240a95>] unregister_netdev+0x15/0x20
 [<e0d3a2b5>] tg3_remove_one+0x25/0x70 [tg3]
 [<c01db4e9>] pci_device_remove+0x69/0x70
 [<c0232646>] device_release_driver+0x86/0x90
 [<c0232a2b>] bus_remove_driver+0x5b/0x100
 [<e0d3a780>] tg3_cleanup+0x0/0x13 [tg3]
 [<c0232fc0>] driver_unregister+0x10/0x20
 [<c01db234>] pci_unregister_driver+0x14/0xa0
 [<e0d3a78f>] tg3_cleanup+0xf/0x13 [tg3]
 [<c013462b>] sys_delete_module+0x17b/0x1e0
 [<c0104ff1>] sysenter_past_esp+0x52/0x71
divert: freeing divert_blk for eth0
