Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUCPR4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUCPOSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:18:18 -0500
Received: from server17.pronicsolutions.com ([64.94.232.3]:51360 "EHLO
	server17.pronicsolutions.com") by vger.kernel.org with ESMTP
	id S261832AbUCPOGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:06:05 -0500
From: "ProNIC Solutions" <mot@pronicsolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.25: attempt to access beyond end of device
Date: Tue, 16 Mar 2004 09:06:31 -0500
Message-ID: <005201c40b5f$e21d34a0$0600a8c0@p17>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server17.pronicsolutions.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pronicsolutions.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Every time I compile 2.4.25 I get the same errors throughout dmesg:

attempt to access beyond end of device
03:02: rw=0, want=1020128, limit=1020127
attempt to access beyond end of device
03:05: rw=0, want=5116672, limit=5116671
attempt to access beyond end of device
03:06: rw=0, want=3068384, limit=3068383

This is happening consistently with every single machine regardless of
the type of hardware. Happens with various partitions, but always trying
to access one inode passt the limit. Reverting back to 2.4.24 gets rid
of the errors. What could have changed with regards to ext3 between
2.4.24 and 2.4.25 that could be triggering these errors? This is only
happening on machines running RedHat 7.3. Newer distributions, such as
RedHat 9 do just fine. Perhaps old libraries? If so, is there a way to
fix this somehow?

Thanks,

Bert

