Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264313AbUEDLzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUEDLzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUEDLzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:55:53 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:15454 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264313AbUEDLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:55:51 -0400
Date: Tue, 4 May 2004 07:00:47 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Slab cache seems to grow forever - 2.6.6-rc3-mm1
Message-ID: <Pine.LNX.4.58.0405040651150.18153@ozma.hauschen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This might be related to the change in fs-writeback.c that fixed
redirtying inodes on NFS, but I'm not sure. It seems that the Slab cache
never shrinks. Could this be a memory leak? It definitely affects system
performance. Here are the numbers after running for about 12 hours with
heavy NFS traffic (this is the client).

What's the best way to see who is allocating Slab memory?

/proc/meminfo
MemTotal:       517044 kB
MemFree:        116876 kB
Buffers:          1176 kB
Cached:          18908 kB
SwapCached:       3428 kB
Active:          17840 kB
Inactive:         8448 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       517044 kB
LowFree:        116876 kB
SwapTotal:      506036 kB
SwapFree:       497804 kB
Dirty:             940 kB
Writeback:           0 kB
Mapped:           9012 kB
Slab:           367588 kB
Committed_AS:    19856 kB
PageTables:        548 kB
VmallocTotal:   516020 kB
VmallocUsed:      8748 kB
VmallocChunk:   506908 kB

Thanks
 - Brent
