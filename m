Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284301AbRLXB2Q>; Sun, 23 Dec 2001 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284304AbRLXB2H>; Sun, 23 Dec 2001 20:28:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:43533 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284301AbRLXB1w>; Sun, 23 Dec 2001 20:27:52 -0500
Date: Sun, 23 Dec 2001 17:31:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Momchil Velikov <velco@fadata.bg>,
        george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011223171802.A19931@hq2>
Message-ID: <Pine.LNX.4.40.0112231722260.971-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Victor Yodaiken wrote:

>
>
> Run a "RT"  task that is scheduled   every millisecond (or time of your
> choice)
> 	while(1`){
> 		read cycle timer
> 		clock_nanosleep(time period using aabsolute time
> 		read cycle timer - what was actual delay? track worst
> 			case
> 		}
>
> Run this
> 	a) on aaaaaaaaan unstressed system
> 	b) under stress
> 	c) while a timed non-rt benchmark runs to figure out "RT"
> 	overhead.

I've coded a test app that uses the LatSched latency patch ( that uses
rdtsc ).
It basically does 1) set the current process priority to RT 2) an ioctl()
to activate the scheduler latency sampler 3) sleep for 1-2 secs 4) ioctl()
to stop the sampler 5) peek the sample with pid == getpid().
In this way i get the net RT task scheduler latency. Yes it does not get
the real one that includes accessories kernel paths but my code does not
affect these ones. And they add noise to the measure.




- Davide


