Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280989AbRKCRZ3>; Sat, 3 Nov 2001 12:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280991AbRKCRZU>; Sat, 3 Nov 2001 12:25:20 -0500
Received: from webmta.etang.com ([202.101.42.208]:32429 "HELO mail.etang.com")
	by vger.kernel.org with SMTP id <S280989AbRKCRZO>;
	Sat, 3 Nov 2001 12:25:14 -0500
MIME-Version: 1.0
Message-Id: <3BE4285F.17379@mail-smtp2>
Date: Sun, 4 Nov 2001 01:24:47 +0800 (CST)
From: "zwpeng" <zwpeng@etang.com>
To: linux-kernel@vger.kernel.org
Subject: =?gb2312?B?OTklIENQVSBieSBrc3dhcGQgb24ga2VybmVsIDIuNC4xMw==?=
X-Priority: 3
X-Originating-IP: [202.108.240.1]
X-Mailer: COREMAIL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'v noticed that Mr  Les Schaffer <schaffer@optonline.net> had reported such
problem on Oct 30 in his mail entiled "2.4.13 (SMP): kswapd working furiously, 
to no effect". So this mail is just to say that the problem had hit more than
one persons.

 I encountered this kswapd problem yesterday after the machine ruuning for 22 hours: 
kswapd crazily use 99% of CPU time even if I switched to single mode.
About half an hour ago, when I starting build the newly 2.2.20 kernel and 
opened a Mozilla session, I noticed that kswapd got crazy again:

 12:48am  up 1 day,  7:05, 14 users,  load average: 2.38, 3.01, 2.37
76 processes: 72 sleeping, 4 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 99.6% system,  0.3% nice,  0.0% idle
Mem:  385280K av, 361776K used,  23504K free,      0K shrd,  10744K buff
Swap: 128484K av,   1160K used, 127324K free                187740K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
    5 root      19   0     0    0     0 RW      0 99.0  0.0   9:37 kswapd
 8337root       17   5  1268 1268  1068 R N     0  0.9  0.3   0:05 top
    1 root       8   0   476  476   412 S       0  0.0  0.1   0:04 init
    2 root       9   0     0    0     0 SW      0  0.0  0.0   0:02 keventd
    3 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 kapm-idled
    4 root      19  19     0    0     0 SWN     0  0.0  0.0   0:00 ksoftirqd_CP
    6 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW      0  0.0  0.0   0:03 kupdated
    8 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 khubd
   56 root       9   0     0    0     0 SW      0  0.0  0.0   0:01 kjournald

Howerver it become quite quiet now. I don't know who has made it 
calm down :-)

  1:19am  up 1 day,  7:36, 14 users,  load average: 0.38, 0.32, 0.92
84 processes: 83 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.0% user,  2.1% system,  1.7% nice, 96.0% idle
Mem:  385280K av, 380824K used,   4456K free,      0K shrd,   9444K buff
Swap: 128484K av,    904K used, 127580K free                188712K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 8337 pzw       16   5  1268 1268  1068 S N     0  1.3  0.3   0:26 top
 9373 pzw       17   5  1268 1268  1068 R N     0  1.3  0.3   0:00 top
 9356 pzw       16   5 28864  28M 14064 S N     0  1.1  7.4   1:00 mozilla-bin
    1 root       8   0   476  476   412 S       0  0.0  0.1   0:04 init
    2 root       9   0     0    0     0 SW      0  0.0  0.0   0:02 keventd
    3 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 kapm-idled
    4 root      19  19     0    0     0 SWN     0  0.0  0.0   0:00 ksoftirqd_CP
    5 root       9   0     0    0     0 SW      0  0.0  0.0  21:58 kswapd
    6 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 bdflush
    7 root       9   0     0    0     0 SW      0  0.0  0.0   0:03 kupdated
    8 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 khubd
   56 root       9   0     0    0     0 SW      0  0.0  0.0   0:01 kjournald
   58 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 kreiserfsd
  104 root       9   0   460  460   404 S       0  0.0  0.1   0:00 apmd
  248 root       9   0   552  552   460 S       0  0.0  0.1   0:00 syslogd
  258 root       9   0  1052 1052   404 S       0  0.0  0.2   0:00 klogd

Regards
     Zhaowang Peng
 





-----------------------------------------
我的姓名  我的邮箱
http://name.etang.com/
亿唐短信，您贴身的时尚顾问
http://sms.etang.com
每天让你轻松记单词
http://www.etang.com/texthanburg/index.htm
中国人性大灾难
http://topic.etang.com/renxing/index.htm  
