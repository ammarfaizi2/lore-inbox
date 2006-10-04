Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWJDUqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWJDUqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWJDUqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:46:39 -0400
Received: from twin.jikos.cz ([213.151.79.26]:4304 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751108AbWJDUqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:46:36 -0400
Date: Wed, 4 Oct 2006 22:46:33 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: DWARF2 unwinder stuck
Message-ID: <Pine.LNX.4.64.0610042223020.12556@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I know you are hunting all the DWARF2 unwinding stucks. I have just got 
the one below, when debuging kernel panic in MPU401 driver, with Linus' 
current git tree.

Do you have fix for this one queued somewhere?

Thanks.

Call Trace:
 [<c025e0a6>]  bus_remove_device+0x78/0x91
 [<c025d106>]  device_del+0x141/0x172
 [<c025fc9a>]  platform_device_unregister+0x8/0x10
 [<c01004ae>]  alsa_card_mpu401_init+0x4c/0x78
 [<c0104087>]  kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:
=======================
Code: fe ff ff 89 d8 e8 89 20 00 00 8d 43 04 8d 56 04 8b 48 04 89 50 04 89 46 04 00 00 89 f8 e8 19 ff ff ff 85 c0 b8 00
EIP: [<c041f280>] klist_del+0x7/0x31 SS:ESP 0068:c14c1f6c

-- 
Jiri Kosina
