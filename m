Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVKBTCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVKBTCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVKBTCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:02:23 -0500
Received: from orb.pobox.com ([207.8.226.5]:58520 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S965182AbVKBTCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:02:23 -0500
Date: Wed, 2 Nov 2005 09:46:39 -0800
From: Chip Salzenberg <chip@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: hostap interrupt problems, maintainers unresponsive - "wifi0: interrupt delivery does not seem to work"
Message-ID: <20051102174639.GB6816@tytlal.topaz.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've sent this problem description to the upstream maintainers three
times and received no reply, let alone illumination.  Thus:

Hostap 0.3.9 under kernel 2.6.12 works fine with the D-Link DWL-650.

Hostap 0.4.4-kernel, included with kernel 2.6.14, does not work; nor
do versions 0.3.9 nor 0.4.1 compiled separately against 2.6.14.  There
seems to be a problem with interrupt delivery.  Soon after the module
is installed, keystrokes and all other interrupt-driven activity pause
periodically for a LONG time (on the order of five seconds).
Keystrokes will often auto-repeat because the key-raise interrupt gets
delayed and the kernel thinks the key is still down.

Here's a log excerpt:

Oct 29 16:34:11 tytlal kernel: usb 2-1: new full speed USB device using uhci_hcd and address 3
Oct 29 16:34:11 tytlal kernel: usb 2-1: configuration #1 chosen from 2 choices
Oct 29 16:34:11 tytlal kernel: cdc_acm 2-1:1.0: ttyACM0: USB ACM device
Oct 29 16:34:23 tytlal kernel: hostap_cs: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
Oct 29 16:34:23 tytlal kernel: hostap_cs: Registered netdevice wifi0
Oct 29 16:34:23 tytlal kernel: hostap_cs: index 0x01: Vcc 3.3, irq 3, io 0x4100-0x413f
Oct 29 16:34:23 tytlal kernel: wifi0: NIC: id=0x800c v1.0.0
Oct 29 16:34:23 tytlal kernel: wifi0: PRI: id=0x15 v1.1.1
Oct 29 16:34:23 tytlal kernel: wifi0: STA: id=0x1f v1.8.4
Oct 29 16:34:26 tytlal kernel: wifi0: Interrupt, but SWSUPPORT0 does not match: 0000 != 8A32 - card removed?
Oct 29 16:34:26 tytlal kernel: hostap_cs: wifi0: resetting card
Oct 29 16:34:42 tytlal pppd[6511]: tcsetattr: No such device or address (line 1010)
Oct 29 16:34:42 tytlal pppd[6511]: Exit.
Oct 29 16:35:57 tytlal kernel: wifi0: interrupt delivery does not seem to work
Oct 29 16:35:57 tytlal kernel: wifi0: cnfAuthentication setting to 0x1 failed
Oct 29 16:37:03 tytlal kernel: hostap_cs: Registered netdevice wifi0
Oct 29 16:37:03 tytlal kernel: hostap_cs: index 0x01: Vcc 3.3, irq 3, io 0x4100-0x413f
Oct 29 16:37:03 tytlal kernel: wifi0: NIC: id=0x800c v1.0.0
Oct 29 16:37:03 tytlal kernel: wifi0: PRI: id=0x15 v1.1.1
Oct 29 16:37:03 tytlal kernel: wifi0: STA: id=0x1f v1.8.4
Oct 29 16:37:05 tytlal kernel: wifi0: Interrupt, but SWSUPPORT0 does not match: 0000 != 8A32 - card removed?
Oct 29 16:37:05 tytlal kernel: hostap_cs: wifi0: resetting card
Oct 29 16:37:10 tytlal kernel: hostap_cs: wifi0: resetting card
Oct 29 16:37:16 tytlal kernel: wifi0: Interrupt, but SWSUPPORT0 does not match: 0000 != 8A32 - card removed?
Oct 29 16:37:16 tytlal kernel: hostap_cs: wifi0: resetting card

-- 
Chip Salzenberg <chip@pobox.com>
