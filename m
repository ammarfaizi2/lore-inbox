Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUAEJuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUAEJuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 04:50:32 -0500
Received: from mailrelay.just.fgov.be ([193.191.208.3]:45582 "EHLO
	mailrelay.just.fgov.be") by vger.kernel.org with ESMTP
	id S263453AbUAEJua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 04:50:30 -0500
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0 and Asus P4P800-VM motherboard
From: Lieven Marchand <mal@wyrd.be>
Date: 05 Jan 2004 10:50:21 +0100
Message-ID: <868ykmiv1e.fsf@wyrd.be>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with the Asus P4P800-VM motherboard, linux 2.6.0 crashes at boot in
the pnpbios routines. It will boot with the pnpbios=off parameter.

The kernel crashes with an invalid EIP so there's no stack trace. I've
added printk's to the code to see what it was doing and it goes wrong
in the initial build_devlist. pnp_bios_get_dev_node gets called in a
loop and it succeeds for the first nodenumbers but it crashes for
nodenumber 0x6.

pnp_bios_get_dev_node gets called with PNPMODE_DYNAMIC.

I've flashed the bios to the latest version available.

Any ideas on what to do to get this thing working?

-- 
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?
