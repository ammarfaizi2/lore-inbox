Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJPN6G>; Tue, 16 Oct 2001 09:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276318AbRJPN54>; Tue, 16 Oct 2001 09:57:56 -0400
Received: from [213.237.118.153] ([213.237.118.153]:17024 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S276312AbRJPN5q>;
	Tue, 16 Oct 2001 09:57:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre3aa1
Date: Tue, 16 Oct 2001 15:55:27 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011016110708.D2380@athlon.random> <E15tTMq-0000E6-00@Princess> <20011016152126.01d58180.skraw@ithnet.com>
In-Reply-To: <20011016152126.01d58180.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Stephan von Krawczynski <skraw@ithnet.com>
Message-Id: <E15tUgv-0000Oh-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 15:21, you wrote:
>
> On my system I cannot see anything the like. Look at the execution time.
> Ok, I must admit: I do not use brain-dead K stuff (warning: this is a very
> personal opinion, don't flame me here :-).
>
> What does your setup look like? Have you ever tested without K?
>
No, I havent tried it without K. The system is quite responsive if I only run 
updatedb, and swap around in either text-linux or a simple X setup. When 
looking closer at the problem, it is the combination of running kmail with 
HUGE folders (think linux-kernel archive), apt-get and anacron that thrashes 
the system. All of these have a "relative" low impact when running alone or 
two and two.
It might be "what you expect" abusing the system like that. But as I said, it 
is not a problem in 2.4.11-pre1 and 2.4.12-ac3. 

Princess:/home# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  196304896 192466944  3837952        0  1327104 33628160
Swap: 255426560 64491520 190935040
MemTotal:       191704 kB
MemFree:          3748 kB
MemShared:           0 kB
Buffers:          1296 kB
Cached:          28196 kB
SwapCached:       4644 kB
Active:          23344 kB
Inactive:        10792 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       191704 kB
LowFree:          3748 kB
SwapTotal:      249440 kB
SwapFree:       186460 kB

Princess:/proc# uname -r
2.4.13-pre2

Princess:/proc# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3             18975356   9843804   8167652  55% /
/dev/hda1                 7318      7241         0 100% /boot

 15:52:56 up  1:03,  2 users,  load average: 3.44, 3.95, 3.16
90 processes: 86 sleeping, 2 running, 2 zombie, 0 stopped
CPU states:  23.7% user,   3.4% system,   0.0% nice,  73.0% idle
Mem:    191704K total,   188024K used,     3680K free,     2652K buffers
Swap:   249440K total,    61744K used,   187696K free,    21268K cached


Does all this help you?

Notice this is not worst case, just what I could reproduce by starting 
updatedb and checksecurity while answering your mail. Switchtime from desktop 
to desktop is 1 minute.

`Allan
