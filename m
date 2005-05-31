Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVEaV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEaV5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEaV5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:57:39 -0400
Received: from dream.eng.uci.edu ([128.195.164.137]:1854 "EHLO
	dream.dream.eng.uci.edu") by vger.kernel.org with ESMTP
	id S261602AbVEaV50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:57:26 -0400
From: "Liangchen Zheng" <zlc@dream.eng.uci.edu>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: The values of gettimeofday() jumps.
Date: Tue, 31 May 2005 14:59:44 -0700
Message-ID: <004d01c5662c$0da4de70$85a4c380@dream.eng.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <1117332028.11397.1.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-OriginalArrivalTime: 31 May 2005 22:01:47.0968 (UTC) FILETIME=[57548C00:01C5662C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the problem is not caused by ntpd. 
The issue is still there after I stopped the ntpd daemon. I tested it
for a long time and found the clock drifted around every 1 second. The
distances of the clock drift are interleaved with both positive and
negative values. For example, if it goes 300ms forward, it will go
backward around 300ms at the next time. Because the occurrences of the
clock drift are so regular, I doubt it was caused only by one source.  I
am still wondering how I can discover it. 
	There were also 2 other suggestions I got from here the last
week. I will try them to see if it can solve my problem. 
	Thanks. 

Regards,
Liangchen 

-----Original Message-----
From: Lee Revell [mailto:rlrevell@joe-job.com] 
Sent: Saturday, May 28, 2005 7:00 PM
To: Liangchen Zheng
Subject: RE: The values of gettimeofday() jumps.

On Sat, 2005-05-28 at 19:00 -0700, Liangchen Zheng wrote:
> Yes. There is an ntp server in the LAN. Is the problem caused by this?
I
> saw some document said the clock drift issue can be solved by using
> ntpd.  
> So if the problem is caused by ntp, how can I solve it?
> Thanks a lot.

Well, if you are running ntpd on all of the machines (and not just
periodically running ntpdate), it should slew the clock gradually, so
you should not see any big jumps.

If all machines are running ntpd locally, and all are configured to use
the same NTP server, all clocks should be in sync all the time.

Lee

