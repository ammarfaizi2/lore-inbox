Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTLEEns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 23:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLEEns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 23:43:48 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:49549 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262092AbTLEEnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 23:43:46 -0500
Date: Thu, 4 Dec 2003 21:54:04 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205045404.GA307@tesore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a NForce2 board and can easily reproduce a lockup with grep on an IDE 
hard disk at UDMA 100.  The lockup occurs when both Local APIC + IO-APIC are 
enabled.  It was suggested to me to use NMI watchdog to catch it.  However, the 
NMI watchdog doesn't seem to work.

When I set the kernel parameter "nmi_watchdog=1" I get this message in 
/var/log/syslog:
Dec  4 20:10:30 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
IO-APIC
Dec  4 20:10:30 tesore kernel: timer doesn't work through the IO-APIC - 
disabling NMI Watchdog!

"nmi_watchdog=2" seems to work at first, In /var/log/messages:
Dec  4 20:13:11 tesore kernel: testing NMI watchdog ... OK.
but it still locks up.

I have the complete logs when running with nmi_watchdog, kernel config, and more
here:
http://www.chez.com/alors/nforce-lockup-logs.tar.gz

If you have any ideas please give them =)

Jesse
