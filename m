Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSAQJRe>; Thu, 17 Jan 2002 04:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSAQJRY>; Thu, 17 Jan 2002 04:17:24 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:56452 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288420AbSAQJRN>; Thu, 17 Jan 2002 04:17:13 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: I3 sched brakes "realtime" task
Date: Thu, 17 Jan 2002 10:17:12 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201170008290.20808-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201170008290.20808-100000@localhost.localdomain>
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020117091722Z288420-13996+7423@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 17. January 2002 00:09, you wrote:
> On Wed, 16 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
> > running I3 on top of 2.4.18-pre3-I3-VM-22-preempt-lock ;-) This
> > combination rouks!
>
> could you try the -J0 patch i've just uploaded? It has a number of fixes
> and improvements.

Somewhat better but a reniced artsd (-16 or -19) stutters a little during 
dbench 32. Maybe there is one show stopper slipped into preempt or lock-break 
during my 10_vm-22 merge. Few stalls during heavy IO. But I have the buffer.c 
fix applied.

2.4.18-pre4-J0-VM-22-preempt-lock

32 clients started
................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..+...................................................................+..+.+.+.++++.++.+...........++...........++...+.+++.+++.........+...+.++.....+...++....+********************************
Throughput 51.711 MB/sec (NB=64.6388 MB/sec  517.11 MBit/sec)
14.260u 49.860s 1:22.71 77.5%   0+0k 0+0io 939pf+0w

More to come after some sleep...

-Dieter

BTW I'll prepare a unified patch for wider testing if anybody want.
