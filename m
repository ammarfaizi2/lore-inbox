Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSINXZI>; Sat, 14 Sep 2002 19:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSINXZI>; Sat, 14 Sep 2002 19:25:08 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:34477 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S317619AbSINXZI>;
	Sat, 14 Sep 2002 19:25:08 -0400
Message-ID: <1032046197.3d83c675c806c@kolivas.net>
Date: Sun, 15 Sep 2002 09:29:57 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: contest benchmark update
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the contest responsiveness benchmark thanks to Rik Van Riel. It now
works on 2.5.x kernels. Here is an updated set of benchmarks:

No Load:

Kernel			Time		CPU
2.4.19			1:07.69		99%
2.4.19-ck7		1:07.62		99%
2.5.34			1:09.97		99%
2.4.19-ck7-rmap		1:08.83		99%
2.4.20-pre7		1:08.53		99%

CPU Load:

Kernel			Time		CPU
2.4.19			1:20.59		80%
2.4.19-ck7		1:10.79		93%
2.5.34			1:12.09		94%
2.4.19-ck7-rmap		1:11.07		93%
2.4.20-pre7		1:22.37		80%

IO Load:

Kernel			Time		CPU
2.4.19			1:50.85		58%
2.4.19-ck7		1:17.07		85%
2.5.34			1:18.43		86%
2.4.19-ck7-rmap		1:21.48		81%
2.4.20-pre7		1:54.14		58%

Mem Load:

Kernel			Time		CPU
2.4.19			1:24.94		77%
2.4.19-ck7		1:11.36		93%
2.5.34			1:20.65		86%
2.4.19-ck7-rmap		1:40.37		68%
2.4.20-pre7		1:28.10		76%


The absolute values are not important, only their differences. The smaller the
difference (in time) between noload and the different loads the better. The
higher the cpu percentage, the better.

I'm working on updating the IO load for the next version to something a bit more
stressful on the system thanks to Andrew Morton's suggestions.

The current version is 0.12 and can be downloaded at my kernel page:
http://kernel.kolivas.net

Cheers,
Con.
