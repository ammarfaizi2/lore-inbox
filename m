Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUCQXAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUCQXAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:00:55 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:31979 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262131AbUCQXAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:00:53 -0500
Message-ID: <4058D8A0.7020507@cyberone.com.au>
Date: Thu, 18 Mar 2004 10:00:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Fleury <fleury@cs.auc.dk>
CC: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Problem ????
References: <1079533212.25474.370.camel@rade7.s.cs.auc.dk>
In-Reply-To: <1079533212.25474.370.camel@rade7.s.cs.auc.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Emmanuel Fleury wrote:

>Hi all,
>
>I am running a 2.6.4 (with preemptible kernel activated). 
>What I did is the following:
>
>1) Compile the sched_test.c program (at the end of the mail):
>
>[root@hermes sched]$ gcc -o sched_test sched_test.c
>
>2) Set the priority of the root shell as the highest:
>[root@hermes sched]$ ps
>  PID TTY          TIME CMD
> 1519 pts/0    00:00:00 bash
> 2020 pts/0    00:00:00 ps
>[root@hermes sched]$ chrt -f -p 99 1519
>
>3) Run sched_test:
>[root@hermes sched]$ chrt -f 10 ./sched_test 100
>bye now.
>  
>
>
>Here during the execution of sched_test everything is frozen.
>
>
>Did I do something wrong ????
>
>

Realtime processes aren't preemptible at all by non realtime
processes or realtime processes of a lesser priority.

