Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278732AbRJ3XSo>; Tue, 30 Oct 2001 18:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278724AbRJ3XSf>; Tue, 30 Oct 2001 18:18:35 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:932 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S278712AbRJ3XSZ>; Tue, 30 Oct 2001 18:18:25 -0500
Date: Tue, 30 Oct 2001 18:16:49 -0500
From: Les Schaffer <schaffer@optonline.net>
Subject: Re: 2.4.13 (SMP): kswapd working furiously, to no effect
In-Reply-To: <15325.64751.75250.887741@gargle.gargle.HOWL>
To: linux-kernel@vger.kernel.org
Message-id: <87bsio3ehq.fsf@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (artichoke)
In-Reply-To: <15325.64751.75250.887741@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've checked 2.4.12 today, and it definitely does NOT have the same
problem as i reported for 2.4.13. so something went wrong in 2.4.13
...


from top:

 18:11:57 up  9:38,  2 users,  load average: 0.05, 0.03, 0.04
84 processes: 83 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   2.0% user,   0.7% system,   0.0% nice,  97.3% idle
Mem:    513912K total,   439012K used,    74900K free,     1580K buffers
Swap:   506036K total,    54320K used,   451716K free,   152492K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  365 godzilla  11   0 84052  60M 15904 S     0.2 12.1  27:15 mozilla-bin
  ...
  294 root      12 -10  204M  28M  5120 S <   1.9  5.6   6:17 XFree86
  352 godzilla  11   0 31708  28M  4304 S     0.4  5.6   5:34 xemacs
  331 godzilla   9   0  3336 2460  2096 S     0.0  0.4   0:07 gabber
  ...
    5 root       9   0     0    0     0 SW    0.0  0.0   0:01 kswapd



for comparison, from 2.4.13 yesterday:


19:07:09 up 13:12,  3 users,  load average: 1.68, 1.45, 1.24
69 processes: 66 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  14.4% user,  85.5% system,   0.0% nice,   0.1% idle
Mem:    513916K total,   443932K used,    69984K free,     7808K buffers
Swap:   506036K total,        0K used,   506036K free,   166992K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 2873 godzilla   9   0 31984  30M 12272 S     0.0  6.0   0:00 mozilla-bin
  ...
  356 godzilla   9   0 27528  26M  3688 S     0.0  5.3   4:16 xemacs
  298 root       6 -10  202M  26M  4120 S <   0.9  5.1   9:04 XFree86
  335 godzilla   9   0  7672 7668  6100 S     0.0  1.4   0:17 gabber
  ...
    5 root      19   0     0    0     0 RW   95.9  0.0 282:40 kswapd

les schaffer
