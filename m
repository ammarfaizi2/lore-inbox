Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVLNDWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVLNDWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVLNDWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:22:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030364AbVLNDWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:22:05 -0500
Date: Tue, 13 Dec 2005 22:22:03 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: stall during boot on x86-64.
Message-ID: <20051214032202.GA3429@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot my EM64T, I get a slight noticable pause
really early on in boot.  Booting with 'time'
shows an interesting artifact.

Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=ttyS0,38400 console=tty0 time
kernel profiling enabled (shift: 1)
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 14.318180 MHz HPET timer.
[    0.000000] time.c: Detected 2793.081 MHz processor.
[   27.449661] Console: colour VGA+ 80x25
[   28.484309] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   28.506519] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   28.539543] Memory: 1014240k/1047080k available (2490k kernel code, 32456k reserved, 1664k data, 236k init)

Note the jump in the time value..
I'm not sure this is actually where the pause I see is, as the text
is buffered, but it's something I can't explain.

		Dave

