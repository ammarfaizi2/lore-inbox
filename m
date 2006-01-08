Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbWAHGQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWAHGQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 01:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWAHGQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 01:16:38 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:8864 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161162AbWAHGQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 01:16:38 -0500
From: Grant Coady <gcoady@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Sun, 08 Jan 2006 17:16:34 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Recently I started testing 2.6 stable on my firewall box here, I 
work via ssh terminals to firewall and have a good feel for the 
CLI responsiveness.

The test?  Just a simple display the apache access log, but it is 
very slow with 2.6 kernels (2.6.14.5, 2.6.14.6, 2.6.15):

2.4.32-hf32.1:
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
[...]
2006-01-08 14:38:52 +1100: bugsplatter.mine.nu 207.46.98.39 "GET /test/linux-2.6/sempro/ HTTP/1.

real    0m1.562s
user    0m0.600s
sys     0m0.310s

2.6.14.6:
grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log |cut -c-96
[...]
2006-01-08 14:38:52 +1100: bugsplatter.mine.nu 207.46.98.39 "GET /test/linux-2.6/sempro/ HTTP/1.

real    0m6.318s
user    0m0.690s
sys     0m1.140s

grant@deltree:~$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I] (rev 02)
00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0e.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:10.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 44)

dmesg + .config on: http://bugsplatter.mine.nu/test/boxen/deltree/

-- 
Thanks,
Grant.
http://bugsplatter.mine.nu/
