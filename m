Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUBUN4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUBUN4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:56:16 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:22469 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S261556AbUBUN4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:56:12 -0500
From: NoTellin <notellin@speakeasy.net>
Organization: --NA--
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Multiple NIC cards in the same machine and 2.5/2.6
Date: Sat, 21 Feb 2004 08:15:55 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402210815.55770.notellin@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use an iptables based firewall. I currently have 4 NIC cards in 
the machine.

My modules.conf file contains the following lines:

alias eth0 ne
alias eth1 ne
options eth0 -o ne-0 io=0x300 irq=3
options eth1 -o ne-1 io=0x200 irq=5
alias eth2 winbond-840
alias eth3 3c509

This works perfectly fine for the 2.4.x series of kernels up to 
and including 2.4.24

However, I can't get this to work in any 2.5/2.6 kernel. The 2.6 
series of kernels will recognize that there are 3 nic cards but 
doesn't seem to accept 2 copies of the ne nic drivers in memory. 
I've tested this up to and including 2.6.3.

I've tried researching this on the 'Net but I've only been able to 
find references suitable for the 2.4 and lesser series of 
kernels. Could someone point me to the equivalent information for 
2.5/2.6 and higher?

Configuration:

90 MHz Pentium Classic, 64 meg ram, 3 gig hardrive.

eth0 - ISA NE2000 - ADSL connection to Internet
eth1 - ISA NE2000 - Lan Segment 2 connection
eth2 - PCI Windbond - Lan segment 1 connection
eth3 - ISA 3com - Cable Modem (backup) connection to the Internet.

Thank you everyone.
Guy


-- 
Free Speech is better than Free Beer
