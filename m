Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbRFCWob>; Sun, 3 Jun 2001 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbRFCWoV>; Sun, 3 Jun 2001 18:44:21 -0400
Received: from sheriff.western.net ([216.216.90.1]:25606 "EHLO
	ponyexpress.western.net") by vger.kernel.org with ESMTP
	id <S263793AbRFCWoP>; Sun, 3 Jun 2001 18:44:15 -0400
Message-Id: <v03110701b7406cf25df5@[24.221.20.19]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 3 Jun 2001 15:47:12 -0700
To: linux-kernel@vger.kernel.org
From: Clinton Hogge <clint@western.net>
Subject: isc_time_now Fatal Error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've sent the following to the Bind9-Users list. It appears that this is a
kernel-related bug and they suggested I post it here as well.

I'm running Linux 2.4.5 and Bind 9.1.2 on a PowerPC. The same error has
popped up under 2.4.3 as well.

Please CC me with any responses as I'm not yet subscribed to this list.
Thanks in advance for any suggestions.

Clinton Hogge
Industrial Images

Original message:
----------------
Named (9.1.2) failed at about 3 this morning (it seems that's always the
time for problems :) with:

timer.c:646: fatal error:
RUNTIME_CHECK(isc_time_now(&now) == 0) failed
exiting (due to fatal error in library)

I saw one other post in the Bind9 archives regarding the same error.

Mark Andrews responded:

>The error message indicated isc_time_now() failed.  Now
>isc_time_now() can fail for a number of reasons, the most
>likely one is that gettimeofday() returned a time with
>tv_usec out of range.  i.e. you detected a kernel bug.
>
>This can often be fixed by the following.
>
>sysctl -w kern.timecounter.method=1

The only problem is that the original poster is running FreeBSD
3.3-RELEASE. My boxes are Power PCs running Linux 2.4.5 - sysctl reports
the above fix as an "unknown key."

Is there an equivalent fix for Linux?



