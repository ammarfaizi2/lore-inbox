Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVCQEGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVCQEGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVCQEGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:06:32 -0500
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:60607 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262996AbVCQEG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:06:28 -0500
Date: Thu, 17 Mar 2005 05:06:23 +0100
From: Voluspa <lista1@telia.com>
To: linux-os@analogic.com
Cc: hancockr@shaw.ca, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: Awful long timeouts for flash-file-system
Message-Id: <20050317050623.14f24754.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At 2005-03-15 0:28:59 linux-os wrote:

> But when it is on a system that is booting from a real drive, I get
> the following errors, each one taking 15 seconds to time-out.

I'm getting these freezes (timeouts) sporadicly on a normal IDE system
during normal runtime. Ext2 file system, no pattern except that it
never happens on the hdb disk. On hdc there is a cdrw and hdd a dvd:

loke:loke:~$ uname -r
2.6.11
loke:loke:~$ grep dma_timer_expiry /var/log/kernel
Mar  3 18:03:01 loke kernel: hda: dma_timer_expiry: dma status == 0x61
Mar  4 19:54:47 loke kernel: hda: dma_timer_expiry: dma status == 0x61
Mar 13 18:52:13 loke kernel: hda: dma_timer_expiry: dma status == 0x61
Mar 15 13:35:10 loke kernel: hda: dma_timer_expiry: dma status == 0x61
Mar 15 19:38:47 loke kernel: hda: dma_timer_expiry: dma status == 0x61
loke:loke:~$ 

It began with kernel 2.6.11 and I reported it immediately:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110987450912711&w=2

Prior to that I was running 2.6.11-rc4 from Feb 13 to Feb 24 and -rc5
from Feb 24 to Mar 3 without these freezes. But perhaps that was too
short periods to catch anything.

Adding Bartlomiej Zolnierkiewicz to the CC list since it should be in
his corner.

Mvh
Mats Johannesson
--
