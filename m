Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268813AbUHUBhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268813AbUHUBhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUHUBhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:37:15 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:61601 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S268813AbUHUBhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:37:13 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: <linux-kernel@vger.kernel.org>
Subject: Cursed Checksums
Date: Sat, 21 Aug 2004 04:37:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSHJ8Un+xDlIZiqQRS39NZ/QOafMg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268813AbUHUBhN/20040821013713Z+1335@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an issue with the incorrect TCP and UDP checksum dropped by the
kernel. A network node is calculating TCP/UDP header checksums with wrong
psuedo-headers, so kernel does not let these packets to reach to userspace;

When I manually calcaulate the checksum in the incoming TCP and UDP packets
and re-inject them back to the socket, everything works fine. That is, the
data integrity is not damaged or corrupted at all.

I tried to investigate the code in tcp_input.c and udp.c to see if I can
disable the checksum control for inbound packets entirely. No use it was
since I need to do this urgently.

Any ideas?


