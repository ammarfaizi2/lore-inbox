Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHAMUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHAMUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 08:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUHAMUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 08:20:22 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:9100 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S261474AbUHAMUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 08:20:19 -0400
Date: Sun, 1 Aug 2004 14:19:31 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: SCSI removable devices problem
Message-Id: <20040801141931.6e026422.pochini@shiny.it>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It seems that 2.6.7 reads the partition table only once: when the scsi unit
is added to the list during boot or when I send the "add-single-device"
command. This is a problem with removable devices because if the drive
hasn't a disk inserted at boot time, attempting to mount a partitioned disk
always results in:

mount: /dev/sdb1 is not a valid block device

Also, bad things may happen (not tested) if a disk was in during boot and I
replace it with another one with a different partitioning.

As a workaround I have to send the "remove-single-device" command after
having unmounted a volume and "add-single-device" after I have inserted a
new one. I don't know when this problem was introduced, sorry.



--
Giuliano.
