Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbRCLQvl>; Mon, 12 Mar 2001 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCLQvc>; Mon, 12 Mar 2001 11:51:32 -0500
Received: from f197.law11.hotmail.com ([64.4.17.197]:64778 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130498AbRCLQvO>;
	Mon, 12 Mar 2001 11:51:14 -0500
X-Originating-IP: [204.69.198.2]
From: "Ying Chen" <yingchenb@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: raw device and linux scheduling performance weirdness
Date: Mon, 12 Mar 2001 08:50:42 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F197UKIh7ClEBMlIPWA000075e0@hotmail.com>
X-OriginalArrivalTime: 12 Mar 2001 16:50:43.0109 (UTC) FILETIME=[93A45550:01C0AB14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran some really trivial raw disk performance tests on 2.4.0 using
the raw disk support in it. I seem to be getting some really strange
performance results. My program opens up a raw device, then does
a sequence of sequential/random reads/writes on the raw device using
pread/pwrite. I put timing around both the sequence and the individual
requests. I noticed that in some of the runs the elapsed time for
the whole sequence of I/O requests is significantly longer than
the sum of the individual I/O request response times (like 100 times
longer say), yet my program does nothing in between the requests but
a gettimeofday call to record the request starting time. The system
has nothing else running when the tests were run, so the process should not 
be contenting with other things.

This seems to me that somehow the raw device I/O process is either
stuck or the linux scheduler is skewing things up somewhere. I tried to nice 
the process to higher priority values, it didn't seem to help.
Any ideas?

Thanks,

Ying

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

