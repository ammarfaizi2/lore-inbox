Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132717AbRDIKq5>; Mon, 9 Apr 2001 06:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132719AbRDIKqs>; Mon, 9 Apr 2001 06:46:48 -0400
Received: from [217.13.10.51] ([217.13.10.51]:61108 "HELO mushkin.ii.uib.no")
	by vger.kernel.org with SMTP id <S132717AbRDIKqi>;
	Mon, 9 Apr 2001 06:46:38 -0400
Date: Mon, 9 Apr 2001 11:43:51 +0200
From: Jan-Frode Myklebust <janfrode@ii.uib.no>
To: linux-kernel@vger.kernel.org
Subject: spurious APIC interrupt on CPU#0
Message-ID: <20010409114351.A18170@ii.uib.no>
Mail-Followup-To: Jan-Frode Myklebust <janfrode@ii.uib.no>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had a (quite) hard hang with 2.4.3-XFS (cvs from oss.sgi.com).
The machine got totally unresponsive in X, and it barely managed to execute
any commands from the serial console. After issuing a reboot, and waiting
for quite some time, I flipped the powerswitch.

Frm the syslog it looks like it started with:

kernel: spurious APIC interrupt on CPU#0, should never happen.

then there's repeated messages like:

kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
kernel: hdc: lost interrupt


This was on a K6-2, kernel config and hardware information available upon
request.


   -jf
