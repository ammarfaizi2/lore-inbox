Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275545AbRIZTmc>; Wed, 26 Sep 2001 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275547AbRIZTmW>; Wed, 26 Sep 2001 15:42:22 -0400
Received: from mail.spylog.com ([194.67.35.220]:46976 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275545AbRIZTmK>;
	Wed, 26 Sep 2001 15:42:10 -0400
Date: Wed, 26 Sep 2001 23:42:30 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10.aa1 & memory use.
Message-ID: <20010926234230.A27587@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010923222036.A1685@taral.net> <20010923233022.A30991@lnuxlab.ath.cx> <20010925204047.A2818@srcf.ucam.org> <20010926104954.B1651@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20010926104954.B1651@suse.cz>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hardware: 1-2Gb RAM/2CPU P3/Intel L440GX(Lancewood)/
kernel always compiled with HIGHMEM 4Gb 


Why big different in RSS?


1. 2.4.10.aa1 (with use 3.5Gb user memory)

 USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
 ...
 vz       12724  0.0 529.3 44044 4197330108 ? S    15:10   0:00 hits
 vz       12742  0.0 529.3 44044 4197330108 ? S    15:10   0:00 hits
 ...

 samson:/spylog/layers # cat /proc/meminfo 
         total:    used:    free:  shared: buffers:  cached:
				 Mem:  1052700672 1046339584  6361088        0 29564928 459169792
				 Swap: 6292217856 289193984 6003023872
				 MemTotal:      1028028 kB
				 MemFree:          6212 kB
				 MemShared:           0 kB
				 Buffers:         28872 kB
				 Cached:         419276 kB
				 SwapCached:      29132 kB
				 Active:          75736 kB
				 Inactive:       401544 kB
				 HighTotal:      655296 kB
				 HighFree:         2044 kB
				 LowTotal:       372732 kB
				 LowFree:          4168 kB
				 SwapTotal:     6144744 kB
				 SwapFree:      5862328 kB
samson:/spylog/layers #

2. 2.4.7.SuSE.3

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
...
vz       27083  0.0  0.8 83992 17596 ?       S    Aug31   0:13 hits
vz       27090  0.0  0.8 83992 17596 ?       S    Aug31   0:59 hits
vz        7121  1.5  0.8 83968 17576 ?       S    23:32   0:00 hits
vz        7166  1.4  0.8 83968 17576 ?       S    23:33   0:00 hits
...

opal:~ # cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
				Mem:  2108891136 2102845440  6045696        0 26062848 1210761216
				Swap: 8589869056 432517120 8157351936
				MemTotal:      2059464 kB
				MemFree:          5904 kB
				MemShared:           0 kB
				Buffers:         25452 kB
				Cached:         983724 kB
				SwapCached:     198660 kB
				Active:         285104 kB
				Inact_dirty:    910292 kB
				Inact_clean:     12440 kB
				Inact_target:     5772 kB
				HighTotal:     1179584 kB
				HighFree:         2812 kB
				LowTotal:       879880 kB
				LowFree:          3092 kB
				SwapTotal:     8388544 kB
				SwapFree:      7966164 kB
opal:~ #


-- 
bye.
Andrey Nekrasov, SpyLOG.
