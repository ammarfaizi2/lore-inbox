Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTB0VMB>; Thu, 27 Feb 2003 16:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTB0VMB>; Thu, 27 Feb 2003 16:12:01 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:21915 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S266114AbTB0VMA>;
	Thu, 27 Feb 2003 16:12:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Rising io_load results Re: 2.5.63-mm1
Date: Fri, 28 Feb 2003 08:22:09 +1100
User-Agent: KMail/1.5
References: <20030227025900.1205425a.akpm@digeo.com>
In-Reply-To: <20030227025900.1205425a.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302280822.09409.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I mentioned this previously; it's still happening.

This started some time around 2.5.62-mm3 with the io_load results on contest 
benchmarking (http://contest.kolivas.org) rising with each run. It still 
occurs with 2.5.63-mm1 regardless of which elevator is specified. This is the 
io load result time(seconds) for 6 consecutive runs in compile time:

111
147
221
284
334
358

/proc/meminfo after 6 runs and mem flushing:

MemTotal:       256156 kB
MemFree:        238708 kB
Buffers:          2320 kB
Cached:           1552 kB
SwapCached:       1780 kB
Active:           5876 kB
Inactive:         2120 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256156 kB
LowFree:        238708 kB
SwapTotal:     4194272 kB
SwapFree:      4192416 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:       4294923652 kB
Slab:             4872 kB
Committed_AS:     7032 kB
PageTables:        200 kB
ReverseMaps:       631

I am refraining from publishing any benchmark results with this happening. It 
doesn't seem to occur on 2.5.63

Con
