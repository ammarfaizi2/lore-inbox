Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUCNF5t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbUCNF5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:57:48 -0500
Received: from main.gmane.org ([80.91.224.249]:54711 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263295AbUCNF5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:57:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: 2.6.4-mm1: kernel oops when rmmod'ing ALSA modules
Date: Sat, 13 Mar 2004 21:57:54 -0800
Message-ID: <pan.2004.03.14.05.57.54.115840@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-222-152.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# modprobe -r snd-intel8x0

Badness in remove_proc_entry at fs/proc/generic.c:664
Call Trace:
 [<c017dfde>] remove_proc_entry+0x10e/0x170
 [<c0308542>] snd_info_unregister+0x52/0x80
 [<c030803f>] snd_info_card_free+0x2f/0x60
 [<c0306870>] snd_card_free+0xf0/0x230
 [<c016a9c3>] iput+0x63/0x80
 [<c01675e4>] dput+0x24/0x270
 [<e1952321>] snd_intel8x0_remove+0x21/0x30 [snd_intel8x0]
 [<c0230ce9>] pci_device_remove+0x39/0x40
 [<c02981c6>] device_release_driver+0x66/0x70
 [<c02981f2>] driver_detach+0x22/0x40
 [<c0298495>] bus_remove_driver+0x55/0x90
 [<c02988ba>] driver_unregister+0x1a/0x42
 [<c0230ea7>] pci_unregister_driver+0x17/0x30
 [<e1952592>] alsa_card_intel8x0_exit+0x12/0x2b [snd_intel8x0]
 [<c0130dfe>] sys_delete_module+0x13e/0x190
 [<c0145867>] sys_munmap+0x57/0x80
 [<c03933db>] syscall_call+0x7/0xb

-- 
Joshua Kwan


