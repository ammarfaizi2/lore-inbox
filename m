Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264270AbRFOIf0>; Fri, 15 Jun 2001 04:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264271AbRFOIfQ>; Fri, 15 Jun 2001 04:35:16 -0400
Received: from [212.141.54.101] ([212.141.54.101]:21636 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S264270AbRFOIfA>; Fri, 15 Jun 2001 04:35:00 -0400
Date: Fri, 15 Jun 2001 10:34:50 +0200
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Odd size of Shared Memory
Message-ID: <20010615103450.A256@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying 2.4.5-ac14 this morning. I issued some command to test
buffer and page cache behaviour

I run 2 cat /dev/hda > /dev/null and  find / -name \* concurrently

When find finished I ran free and it gave me

fourier:~# free
             total       used       free     shared    buffers	cached
Mem:        126996     124104       2892 4294967212      98944	9148
-/+ buffers/cache:      16012     110984
Swap:       128480       3760     124720

fourier:~# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
	Mem:  130043904 127098880  2945024 4294881280 100589568  9969664
	Swap: 131563520  3850240 127713280
	MemTotal:       126996 kB
	MemFree:          2876 kB
	MemShared:    4294967212 kB
	Buffers:         98232 kB
	Cached:           9736 kB
	Active:          93716 kB
	Inact_dirty:     12848 kB
	Inact_clean:      1320 kB
	Inact_target:        4 kB
	HighTotal:           0 kB
	HighFree:            0 kB
	LowTotal:       126996 kB
	LowFree:          2876 kB
	SwapTotal:      128480 kB
	SwapFree:       124720 kB
	
It seems a kernel bug to me, but it didn't hurt, my PC is working
without problems

	Gianluca Anzolin
