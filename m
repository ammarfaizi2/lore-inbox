Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUF1VZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUF1VZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUF1VZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:25:39 -0400
Received: from mail.hardcore-gaming.net ([69.93.101.157]:9605 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S265224AbUF1VZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:25:08 -0400
Message-ID: <40E08CB1.3020500@clanhk.org>
Date: Mon, 28 Jun 2004 15:25:05 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: Timer and APIC problems on x86_64 with 2.6.7
Content-Type: multipart/mixed;
 boundary="------------090300030502020607070904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300030502020607070904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Though 2.6.7 defaults to using APIC, I still get the following with it 
turned on from a Via K8T800 chipset:

Jun 27 21:55:29 palace hda: dma_timer_expiry: dma status == 0x24
Jun 27 21:55:39 palace hda: DMA interrupt recovery
Jun 27 21:55:39 palace hda: lost interrupt
Jun 27 21:57:50 palace hdc: dma_timer_expiry: dma status == 0x24
Jun 27 21:58:00 palace hdc: DMA interrupt recovery

I also saw the following new errors:

Jun 28 03:18:27 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:27 palace warning: many lost ticks.
Jun 28 03:18:27 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:27 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:30 palace warning: many lost ticks.
Jun 28 03:18:30 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:30 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:30 palace warning: many lost ticks.
Jun 28 03:18:30 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:30 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:31 palace warning: many lost ticks.
Jun 28 03:18:31 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:31 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:31 palace warning: many lost ticks.
Jun 28 03:18:31 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:31 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:32 palace warning: many lost ticks.
Jun 28 03:18:32 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:32 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:32 palace warning: many lost ticks.
Jun 28 03:18:32 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:32 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:33 palace warning: many lost ticks.
Jun 28 03:18:33 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:33 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:33 palace warning: many lost ticks.
Jun 28 03:18:33 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:33 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:35 palace warning: many lost ticks.
Jun 28 03:18:35 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:35 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:35 palace warning: many lost ticks.
Jun 28 03:18:35 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:35 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:38 palace warning: many lost ticks.
Jun 28 03:18:38 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:38 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:38 palace warning: many lost ticks.
Jun 28 03:18:38 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:38 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:38 palace warning: many lost ticks.
Jun 28 03:18:38 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:38 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:38 palace warning: many lost ticks.
Jun 28 03:18:38 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:40 palace warning: many lost ticks.
Jun 28 03:18:40 palace Your time source seems to be instable or some 
driver is hogging interupts
Jun 28 03:18:40 palace Losing some ticks... checking if CPU frequency 
changed.
Jun 28 03:18:40 palace warning: many lost ticks.
Jun 28 03:18:40 palace Your time source seems to be instable or some 
driver is hogging interupts

I rebooted with "noapic" on the kernel and haven't seen this 
again...yet...  Attaching a small (1KB) .png of CPU usage, notice the 
system time spike around 3:18AM?  This is a 2.6.7 kernel with the 
x86_64-2.6.7-2 patchset.

-ryan

--------------090300030502020607070904
Content-Type: image/png;
 name="cpu_usage.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cpu_usage.png"

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
/h+yvtYPYANSrAAAAABJRU5ErkJggjczNjY=
--------------090300030502020607070904--
