Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSITHs4>; Fri, 20 Sep 2002 03:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSITHs4>; Fri, 20 Sep 2002 03:48:56 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:30429 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261342AbSITHsz>; Fri, 20 Sep 2002 03:48:55 -0400
Message-ID: <20020920075131.3155.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 20 Sep 2002 15:51:30 +0800
Subject: Re: [chatroom benchmark version 1.0.1] Results
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@aracnet.com>
[...]
> Any chance of doing two runs on exactly the same kernel, one with 
> preempt on, and the other with preempt off? That's a much nicer 
> hint ;-)

Here is the result from 2.5.33

2.5.33-no_preemption.results:Average throughput :59695 messages per second

2.5.33.results:Average throughput : 59522 messages per second

No benefit from preemption.

Anyway, I'll back tomorrow with the results from 2.5.36 (with and withou preemption) running the test 
10 times and evaluating the average.
I'm gonna using this script:
#!/bin/sh
> `uname -r`_total.results
for i in `seq 1 1 10`
do
	./chat_c 127.0.0.1 30 1000 9999 >>`uname -r`_total.results
done
grep Average `uname -r`_total.results |cut -d " " -f 4| awk '{tot+=$1}; END {print "Average throughput: " tot/NR " messages per second"}'

If you have any suggestion, just let me know.

Ciao,
        Paolo


-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
