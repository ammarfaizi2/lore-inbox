Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUALT06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUALT06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:26:58 -0500
Received: from colino.net ([62.212.100.143]:46580 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S266265AbUALT04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:26:56 -0500
Date: Mon, 12 Jan 2004 20:17:08 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: Badness in ohci-hcd
Message-Id: <20040112201708.3102a2d6.colin@colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Disconnecting a GPRS modem (cdc-acm, compiled as module) from an iBook G4
running 2.6.1-ben1 gives the following log:

usb 4-1: USB disconnect, address 3
Badness in ohci_endpoint_disable at drivers/usb/host/ohci-hcd.c:334
Call trace:
 [c000ba60] dump_stack+0x18/0x28
 [c0008ce0] check_bug_trap+0x84/0xac
 [c0008e2c] ProgramCheckException+0x124/0x154
 [c00083b4] ret_from_except_full+0x0/0x4c
 [eb04729c] ohci_endpoint_disable+0xa4/0x174 [ohci_hcd]
 [c01a54e0] hcd_endpoint_disable+0x118/0x190
 [c01a6a20] usb_disable_endpoint+0xa8/0xac
 [c01a6b64] usb_disable_device+0xcc/0xd8
 [c01a06e8] usb_disconnect+0x9c/0x134
 [c01a3328] hub_port_connect_change+0x2e8/0x2ec
 [c01a361c] hub_events+0x2f0/0x358
 [c01a36c0] hub_thread+0x3c/0xf8
 [c000b10c] kernel_thread+0x44/0x60

pppd hangs and does not exit after sending it a SIGHUP, too. I don't know if 
this is related...

-- 
Colin
