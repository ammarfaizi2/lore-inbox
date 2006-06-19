Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWFSUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWFSUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWFSUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:51:26 -0400
Received: from lucidpixels.com ([66.45.37.187]:9406 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932305AbWFSUvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:51:25 -0400
Date: Mon, 19 Jun 2006 16:51:24 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: Control-C under High I/O Crashes Box, 2.6.16.20 or 2.6.17
Message-ID: <Pine.LNX.4.64.0606191649380.18637@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very rare, but when it happens it is very irritating.

It has happened on an old Dell Optiplex GX110 (1.0GHZ) and a new 3.4GHZ 
box with a Promise/Maxtor ATA/133 PCI controller.

When more than 1 heavy I/O (cp/mv/etc) process is running and you hit 
control-c on one of the heavy processes, the box locks up and this appears 
in the logs:

Jun 19 06:20:23 p34 kernel: [4295114.329000] hdk: dma_timer_expiry: dma 
status == 0x20
Jun 19 06:20:23 p34 kernel: [4295114.329000] hdk: DMA timeout retry
Jun 19 06:20:23 p34 kernel: [4295114.329000] PDC202XX: Secondary channel 
reset.
Jun 19 06:20:23 p34 kernel: [4295114.329000] hdk: status error: 
status=0x58 { DriveReady SeekComplete DataRequest }
Jun 19 06:20:23 p34 kernel: [4295114.329000] ide: failed opcode was: 
unknown
Jun 19 06:20:23 p34 kernel: [4295114.584000] hdk: status timeout: 
status=0xd0 { Busy }
Jun 19 06:20:23 p34 kernel: [4295114.584000] ide: failed opcode was: 
unknown
Jun 19 06:20:23 p34 kernel: [4295114.584000] PDC202XX: Secondary channel 
reset.
Jun 19 06:20:24 p34 kernel: [4295114.684000] ide5: reset: success

Just thought I'd mention it, maybe other people have also experienced this 
as well.

Justin.

