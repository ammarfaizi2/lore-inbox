Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263810AbSITWyQ>; Fri, 20 Sep 2002 18:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbSITWyQ>; Fri, 20 Sep 2002 18:54:16 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:15025 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263810AbSITWyQ>; Fri, 20 Sep 2002 18:54:16 -0400
Message-ID: <20020920225828.4517.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 21 Sep 2002 06:58:28 +0800
Subject: Re: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm back with the results of the following script:
#!/bin/sh
> `uname -r`_total.results
for i in `seq 1 1 10`
do
	./chat_c 127.0.0.1 30 1000 9999 >>`uname -r`_total.results
done
grep Average `uname -r`_total.results | awk '{tot+=$4}; END {print "Average throughput: " tot/NR " messages per second"}' > `uname -r`.average

Here the results:
2.5.33-preemption.average:Average throughput: 60943.9 messages per second
2.5.33.average:Average throughput: 61779.8 messages per second
2.5.36-preemption.average:Average throughput: 60877.2 messages per second
2.5.36.average:Average throughput: 60858.7 messages per second
2.5.37-preemption.average: Average throughput: 61896.1 messages per second

Comments?

Ciao,
            Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
