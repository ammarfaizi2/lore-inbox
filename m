Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWEaMKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWEaMKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWEaMKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:10:00 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:33721 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964969AbWEaMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:10:00 -0400
From: Oliver =?iso-8859-1?q?K=F6nig?= <k.oliver@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 0-order allocation failed
Date: Wed, 31 May 2006 14:09:40 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605311409.40560.k.oliver@t-online.de>
X-ID: GzNEg8ZQgeVwvTNY9V4skkZvUAQ-+ana-uhz-VMbvABRxbDoamTcc4
X-TOI-MSGID: cca310e2-998f-491f-9d1f-3ae8aef260d7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run Debian 3.1 (Sarge) with Debian-Kernel 2.4.27-3-686-smp on Dell 
Poweredge 2850 with the following setup/config:

Model: Dell Poweredge 2850
CPU: 2x3.0 GHz
RAM: 2 GB
SWAP: 1 GB
Raid 1 with Dell PowerEdge Expandable RAID controller 4 (SCSI)
Kernel: 2.4.27-3-686-smp (CONFIG_HIGHMEM4G=y)
Web server: apache2
SQL server: mysql4.1
MTA: exim4

Occasionally all of a sudden the load average increases from around 1 
to 50-150. Primarily apache2 and also mysql are then consuming most of the CPU 
and memory. I checked the hardware with the Dell 32-bit diagnostic but could 
not find any errors. /var/log/message produces the following or similar 
output:

May 24 09:06:44 server kernel: VM: killing process cron
May 24 09:06:44 server kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
May 24 09:06:44 server last message repeated 6 times
May 24 09:06:44 server kernel: VM: killing process apache2
May 24 09:06:56 server logger: Hole TAFSYNOP-Wetterdaten...
May 24 09:11:09 server kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
[..]

The server is then so slow tom react that the only way to get rid of the 
problem is to reset the server.

What can we do to fix the problem?
Thanks.
Oliver
