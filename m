Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267200AbUFZWXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbUFZWXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267213AbUFZWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 18:23:31 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:32787 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S267200AbUFZWX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 18:23:27 -0400
Date: Sat, 26 Jun 2004 17:23:04 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: 8139too in 2.6.x tx timeout
Message-ID: <20040626222304.GA31195@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem appears similar to the thread earlier this year with
the subject '2.6.3 - 8139too timeout debug info', but I don't think
it is, since the 2.6.2 driver and patches given in that thread
don't appear to work.

I have enabled debug in the stock Linux 2.6.7 8139too.c and posted it at:
http://zinx.xmms.org/misc/tmp/8139too.debug
The debug shows init, DHCP request (succeeded), then a ping -f that lasts
until shortly after it timed out.

It appears to be losing interrupts, but I don't know the cause, and
don't know how to work around it.  The BIOS is extremely dumb, and has
no option for level/edge, or anything even remotely useful.

I can apply patches, twiddle settings, and provide any debug info needed.

Network:
10mbps half-duplex (detected correctly)

Hardware:
Thinkpad 600E
GigaFast EE102-DLX (RTL-8139C chip)

Kernel config:
ACPI and APIC disabled completely (and the hardware does not support)
HZ=1000 and HZ=100 (via include/asm-i386/param.h); results seem identical.

Software (working with no timeouts):
Linux 2.4.24-xfs (knoppix v3.3 2004-02-16)

Software (extremely frequent tx timeouts, even under fairly low loads
such as only ssh):
Linux 2.6.7 (vanilla)
Linux 2.6.7 w/ "8139too-config-napi.patch"
Linux 2.6.7 + Linux 2.6.2 8139too.c w/ PF_IOTHREAD -> PF_FREEZE

-- 
Zinx Verituse                                    http://zinx.xmms.org/
