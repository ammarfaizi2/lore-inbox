Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbUABIpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 03:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbUABIpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 03:45:18 -0500
Received: from colino.net ([62.212.100.143]:247 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S265439AbUABIpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 03:45:14 -0500
Date: Fri, 2 Jan 2004 09:44:17 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: Strange cdc-acm behaviour
Message-Id: <20040102094417.432e342a.colin@colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I upgraded to 2.6.1-rc1-ben1 (BenH tree), modem hangups using USB
phone (cdc-acm) cause ohci-hcd to disable itself:

# killall -HUP pppd && tail /var/log/syslog
Jan  2 09:39:02 [pppd] Hangup (SIGHUP) 
Jan  2 09:39:02 [pppd] Connection terminated. 
Jan  2 09:39:02 [pppd] Connect time 0.5 minutes. 
Jan  2 09:39:02 [pppd] Sent 283 bytes, received 273 bytes. 
Jan  2 09:39:03 [kernel] ohci_hcd 0001:01:1b.0: OHCI Unrecoverable Error, 
disabled 
Jan  2 09:39:03 [pppd]Exit.

I built ohci-hcd as a module to be able to re-use USB devices without
rebooting (using rmmod && modprobe). 
It didn't do that with the last version I had, which was 2.6.0-test11-benh.

Happy new year to everyone,
-- 
Colin
