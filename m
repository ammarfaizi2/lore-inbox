Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRCPPvB>; Fri, 16 Mar 2001 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbRCPPuv>; Fri, 16 Mar 2001 10:50:51 -0500
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:11534 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S130600AbRCPPun>; Fri, 16 Mar 2001 10:50:43 -0500
Message-ID: <002601c0ae31$7736e250$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: pkt_sched.h
Date: Fri, 16 Mar 2001 23:55:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I have two questoins regarding the pkt_sched.h file.
--
(1)
The pkt_sched.h file have following lines

#define PSCHED_GETTIMEOFDAY 1
#define PSCHED_JIFFIES                  2
#define PSCHED_CPU                       3
#define PSCHED_CLOCK_SOURCE PSCHED_JIFFIES

Does it means that the PSCHED_GET_TIME(stamp) 
use PSCHED_JIFFIES?
If we change it become as follows, then the PSCHED_GET_TIME(stamp)
use PSCHED_CPU?

#define PSCHED_CLOCK_SOUCE PSCHED_CPU

--
(2)
How can we measure the delay of kernel function using
PSCHED_GET_TIME function?
(I only know how to use do_gettimeofday)

do_gettimeofday(&begin);
...
(kernel do something)
...
do_gettimeofday(&end);
if (end.tv_usec < begin.tv_usec) {
    end.tv_usec += 1000000; end.tv_sec--;
}
end.tv_sedc -= begin.tv_sec;
end.tv_usec -= begin.tv_usec;
result = ((end.tv_sec*1000000) + end.tv_usec);

Thanks a lot.
Cheers,
Steven



