Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274657AbRITVm7>; Thu, 20 Sep 2001 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274659AbRITVmt>; Thu, 20 Sep 2001 17:42:49 -0400
Received: from lilly.ping.de ([62.72.90.2]:31506 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S274657AbRITVma>;
	Thu, 20 Sep 2001 17:42:30 -0400
Date: 20 Sep 2001 23:42:11 +0200
Message-ID: <20010920234211.B2059@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: linux-kernel@vger.kernel.org
Subject: Performance of 2.4.10-pre12aa1
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I forgot to CC linux-kernel so here comes my performance measurements
(make -j50 bzImage modules) which show that 2.4.10-pre12aa1 is faster
than 2.4.9-ac12 and way faster than 2.4.10-pre10.

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>

--opJtzjQTFsWo+cga
Content-Type: message/rfc822
Content-Disposition: inline

Date: Thu, 20 Sep 2001 14:18:15 +0200
To: Andrea Arcangeli <andrea@suse.de>
Subject: Performance of 2.4.10-pre12aa1
Message-ID: <20010920141815.A8193@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i

Hello Andrea,

I did some kernel compiling test (make -j50 bzImage modules) and
2.4.10-pre12aa1 is clearly the fastest kernel on my system:

2.4.10-pre12aa1:

	Command being timed: "sh -c make dep clean>logfile-2.4.10-pre12aa1-1000985915 2>&1 && make -j50 bzImage modules>>logfile-2.4.10-pre12aa1-1000985915 2>&1"
	User time (seconds): 271.15
	System time (seconds): 22.80
	Percent of CPU this job got: 85%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:43.77
	Major (requiring I/O) page faults: 1219007
	Minor (reclaiming a frame) page faults: 1068599

2.4.9-ac12:

	Command being timed: "sh -c make dep clean>logfile-2.4.9-ac12-1000986647 2>&1 && make -j50 bzImage modules>>logfile-2.4.9-ac12-1000986647 2>&1"
	User time (seconds): 264.49
	System time (seconds): 24.53
	Percent of CPU this job got: 79%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 6:05.27
	Major (requiring I/O) page faults: 1196824
	Minor (reclaiming a frame) page faults: 1155328

2.4.10-pre10:

	Command being timed: "sh -c make dep clean>logfile-2.4.10-pre10-1000987167 2>&1 && make -j50 bzImage modules>>logfile-2.4.10-pre10-1000987167 2>&1"
	User time (seconds): 265.81
	System time (seconds): 24.04
	Percent of CPU this job got: 54%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 8:55.74
	Major (requiring I/O) page faults: 1221867
	Minor (reclaiming a frame) page faults: 1171864

Although 2.4.9-ac12 is not that far behind. I think the skipping is
caused by some reiserfs problems which show more if your vm changes
are applied.

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>

--opJtzjQTFsWo+cga--
