Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRCATGL>; Thu, 1 Mar 2001 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRCATGA>; Thu, 1 Mar 2001 14:06:00 -0500
Received: from mailf.telia.com ([194.22.194.25]:19208 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S129807AbRCATFs>;
	Thu, 1 Mar 2001 14:05:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Where is my memory
Date: Thu, 1 Mar 2001 19:57:33 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <15006.2724.21532.387750@hertz.ikp.physik.tu-darmstadt.de>
In-Reply-To: <15006.2724.21532.387750@hertz.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Message-Id: <01030119573300.01434@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is interesting.

I have found out that my freezes most oftenly happen on cold boot.
At cold boot the locatedb is run...

I have added IKD...

/RogerL


On Thursday 01 March 2001 09:39, Uwe Bonnes wrote:
> Hallo,
>
> on two systems with 2.4.2. (actually the suse tree from Hubert mantel at
> ftp://ftp.suse.com/people/mantel/next) on a single/dual celeron machine
> with 256/384 MByte Memory all show increased memory consumption after the
> daily locatedb run.
>
> Here is the output in that situation after a shutdown to single user mode
> ("init S"):
>
> (cat /proc/meminfo)
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  261672960 217587712 44085248        0  7565312 87621632
> Swap: 537214976        0 537214976
> MemTotal:       255540 kB
> MemFree:         43052 kB
> MemShared:           0 kB
> Buffers:          7388 kB
> Cached:          85568 kB
> Active:           6204 kB
> Inact_dirty:     75768 kB
> Inact_clean:     10984 kB
> Inact_target:        8 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       255540 kB
> LowFree:         43052 kB
> SwapTotal:      524624 kB
> SwapFree:       524624 kB
>
> (ps axl)
>
>   F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME
> COMMAND 100     0     1     0   9   0   404  220 do_sel S    ?         
> 0:04 init 040     0     2     1   9   0     0    0 contex SW   ?         
> 0:00 [keventd] 040     0     3     1   9   0     0    0 kswapd SW   ?      
>    0:00 [kswapd] 040     0     4     1   9   0     0    0 krecla SW   ?    
>      0:00 [kreclaimd] 040     0     5     1   9   0     0    0 bdflus SW  
> ?          0:00 [bdflush] 040     0     6     1   9   0     0    0 kupdat
> SW   ?          0:01 [kupdate] 040     0    37     1   9   0     0    0
> reiser SW   ?          0:03 [kreiserfsd] 000     0 13559     1  14   0 
> 2404 1392 wait4  S    tty2       0:00 bash 000     0 13565 13559  18   0 
> 2980 1232 -      R    tty2       0:00 ps axl
>
> Any idea what's going on here?
>
> Thanks

-- 
Home page:
  none currently
