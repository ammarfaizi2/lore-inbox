Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277123AbRJQTq5>; Wed, 17 Oct 2001 15:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277132AbRJQTqs>; Wed, 17 Oct 2001 15:46:48 -0400
Received: from mail4.home.nl ([213.51.129.228]:25076 "EHLO mail4.home.nl")
	by vger.kernel.org with ESMTP id <S277123AbRJQTq3>;
	Wed, 17 Oct 2001 15:46:29 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: elko <elko@home.nl>
To: =?iso-8859-1?q?Jos=E9=20Luis=20Domingo=20L=F3pez?= 
	<jdomingo@internautas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: looking for a preempt-patch for 2.4.10-ac12
Date: Wed, 17 Oct 2001 21:47:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01101619524411.00955@ElkOS> <20011016204753.B1472@dardhal.mired.net>
In-Reply-To: <20011016204753.B1472@dardhal.mired.net>
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01101721471803.00726@ElkOS>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 22:47, José Luis Domingo López wrote:
> On Tuesday, 16 October 2001, at 19:52:44 +0200,
>
> elko wrote:
> > Where can I find a preempt-patch for Linux-2.4.10-ac12 ?
>
> http://tech9.net/rml/linux
>
> But there isn't a patch for this specific kernel version, so you will
> have to download the most similar one and apply it in the hope of not
> getting too much and complex .rej


the patch is there, I applied it together with the stats-patch
and my system is running like a charm right now, never have seen
this kind of response in X.


the only thing is, the perl-script at:
http://www.tech9.net/rml/linux/top-latencies

shows something this:

----[ SNIP ]----
n   min  avg  max  cause   mask start line/file address end line/file
  14 9512 9590 9711  spin_lock 5 2111/tcp_ipv4.c c0226736119/softirq.c
  89 9454 9559 9682  spin_lock 9 2111/tcp_ipv4.c c0226736119/softirq.c
   2 9540 9551 9563  spin_lock 3 2111/tcp_ipv4.c c0226736119/softirq.c
3895 7708 9532 14296 spin_lock 1 2111/tcp_ipv4.c c0226736119/softirq.c
   1 9513 9513 9513  spin_lock 1 2111/tcp_ipv4.c c02267362152/tcp_ipv4.c
 363 3594 6166 9512  spin_lock 0 2111/tcp_ipv4.c c02267362152/tcp_ipv4.c
----[ SNIP ]----

that 3895 number for '2111/tcp_ipv4.c c0226736119/softirq.c'
keeps adding up, how should I translate that? big network
latency, is that what it means? if so, any idea on how
can I fix that??

-- 
ElkOS: 9:18pm up 1:08, 3 users, load average: 2.40, 2.38, 2.28
bofhX: overflow error in /dev/null

