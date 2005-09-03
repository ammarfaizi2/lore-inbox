Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVICIpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVICIpD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVICIpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:45:03 -0400
Received: from lucidpixels.com ([66.45.37.187]:41344 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751194AbVICIpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:45:01 -0400
Date: Sat, 3 Sep 2005 04:45:00 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: 2.6.13+netconsole captures crash
Message-ID: <Pine.LNX.4.63.0509030443260.1566@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.13, I have a simple script that tars the data from the root 
filesystem to a 400GB disk, when this started, I got the following errors 
and then the machine locked up:

Again, 400GB/Seagate+ATA/133, someone should add to the CONFIG_OPTION that 
400GB drives are NOT supported w/ the Promise ATA/133 controllers.

Sep  2 21:00:55 p34 hde: dma_timer_expiry: dma status == 0x20
Sep  2 21:00:55 p34 hde: DMA timeout retry
Sep  2 21:00:55 p34 PDC202XX: Primary channel reset.
Sep  2 21:00:55 p34 hde: timeout waiting for DMA
Sep  2 21:00:55 p34 hde: status error: status=0x58 {
Sep  2 21:00:55 p34 DriveReady
Sep  2 21:00:55 p34 SeekComplete
Sep  2 21:00:55 p34 DataRequest
Sep  2 21:00:55 p34 }
Sep  2 21:00:55 p34 ide: failed opcode was:
Sep  2 21:00:55 p34 unknown
Sep  2 21:00:55 p34 hde: drive not ready for command
Sep  2 21:00:55 p34 hde: status error: status=0x50 {
Sep  2 21:00:55 p34 DriveReady
Sep  2 21:00:55 p34 SeekComplete
Sep  2 21:00:55 p34 }
Sep  2 21:00:55 p34 ide: failed opcode was:
Sep  2 21:00:55 p34 unknown
Sep  2 21:00:55 p34 hde: no DRQ after issuing MULTWRITE_EXT


