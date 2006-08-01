Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWHAJfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWHAJfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWHAJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:35:12 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:26273 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1750761AbWHAJfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:35:10 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 1.607362 secs Process 31933)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: the /proc/meminfo statistics
Date: Tue, 1 Aug 2006 15:09:32 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMEEJDDEAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running the following application.

#include<stdio.h>
#include<stdlib.h>

int main()
{
	unsigned char* arr;
	system("cat /proc/meminfo");
	sleep(25);
	arr = (char *)malloc (1048576);
	system("cat /proc/meminfo");
	sleep(25);
	free(arr);
	system("cat /proc/meminfo");
	sleep(25);
}

I am getting the following meminfo statistics. As I am allocating and
freeing 1024 kb, so I should get the same information through /proc/meminfo:


MemTotal:        14296 kB
MemFree:           912 kB
Buffers:          1448 kB
Cached:           5564 kB
SwapCached:          0 kB
Active:           5480 kB
Inactive:         3664 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14296 kB
LowFree:           912 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           5144 kB
Slab:             1560 kB
CommitLimit:      7148 kB
Committed_AS:     6492 kB
PageTables:        188 kB
VmallocTotal:   630784 kB
VmallocUsed:    262560 kB
VmallocChunk:   366588 kB


MemTotal:        14296 kB
MemFree:           920 kB
Buffers:          1448 kB
Cached:           5564 kB
SwapCached:          0 kB
Active:           5492 kB
Inactive:         3660 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14296 kB
LowFree:           920 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           5152 kB
Slab:             1544 kB
CommitLimit:      7148 kB
Committed_AS:     7652 kB
PageTables:        188 kB
VmallocTotal:   630784 kB
VmallocUsed:    262560 kB
VmallocChunk:   366588 kB


MemTotal:        14296 kB
MemFree:           924 kB
Buffers:          1448 kB
Cached:           5564 kB
SwapCached:          0 kB
Active:           5488 kB
Inactive:         3660 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        14296 kB
LowFree:           924 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           5148 kB
Slab:             1544 kB
CommitLimit:      7148 kB
Committed_AS:     6624 kB
PageTables:        188 kB
VmallocTotal:   630784 kB
VmallocUsed:    262560 kB
VmallocChunk:   366588 kB

I think that the values given in first Committed_AS and 3rd Committed_AS
should be same. But the same is not the case. Why its so?

Anticipation and regards,
Abu.

