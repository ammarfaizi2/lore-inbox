Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267561AbRGQXRC>; Tue, 17 Jul 2001 19:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbRGQXQx>; Tue, 17 Jul 2001 19:16:53 -0400
Received: from 20dyn166.com21.casema.net ([213.17.90.166]:46860 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S267561AbRGQXQs>;
	Tue, 17 Jul 2001 19:16:48 -0400
Date: Wed, 18 Jul 2001 01:13:29 +0200
From: bert hubert <ahu@ds9a.nl>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: huge number of context switches under 2.2.x with SMP & threaded apps
Message-ID: <20010718011329.A1829@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ulrich Drepper <drepper@cygnus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107162325120.933-100000@penguin.transmeta.com> <m3ae24m3ro.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3ae24m3ro.fsf@otr.mynet>; from drepper@redhat.com on Tue, Jul 17, 2001 at 12:08:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A threads related question - I have a nameserver with 8 active threads,
which in turn leads to 6 (in this case) MySQL connections. When
stresstesting this nameserver, we see a *huge* number of context switches.
50.000 has been observered. When raising this to ~50 active threads and ~50
MySQL connections we've seen 100.000 context switches/second. Performance
suffers.

This is a RedHat 6.2 system with a 2.2.16 kernel, 2*PIII, 900MHz.

I saw some mention of this problem on the MySQL site with regards to
processes holding a pthread_mutex_lock() for short amounts of time. They
advise to use 2.4 but right now that is not within the scope of my options.

My question: is there a 2.2 kernel in which this is resolved? And secondly,
is there a way to prevent this problem purely from userspace? In other
words, what causes this problem.

The MySQL site also mentions that 2.4 could do better in some ways,
especially regarding 'overspin'.

Thanks for your time.


-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
