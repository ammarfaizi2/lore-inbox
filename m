Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267764AbUH1UQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUH1UQq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUH1UQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:16:01 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:35789 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267958AbUH1UPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:15:35 -0400
Date: Sat, 28 Aug 2004 22:14:35 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040828201435.GB25523@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828195647.GP5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 12:56:47 -0700, William Lee Irwin III wrote:
> These numbers are somewhat at variance with my experience in the area,
> as I see that the internal algorithms actually dominate the runtime
> of the /proc/ algorithms. Could you describe the processes used for the
> benchmarks, e.g. typical /proc/$PID/status and /proc/$PID/maps for them?

The status/maps numbers below are not only typical, but identical for
all tasks. I'm forking off a defined number of children and then query
their status from the parent.

Because I was interested in delivery overhead, I built on purpose a
benchmark without computationally expensive fields. Expensive field
computation hurts /proc more than nproc because the latter allows you
to have only the currently needed fields computed.

Roger

Name:   nprocbench
State:  T (stopped)
SleepAVG:       0%
Tgid:   6400
Pid:    6400
PPid:   2120
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    100     100     100     100
FDSize: 32
Groups: 4 10 11 18 19 20 27 100 250 
VmSize:     1336 kB
VmLck:         0 kB
VmRSS:       304 kB
VmData:      144 kB
VmStk:        16 kB
VmExe:        12 kB
VmLib:      1140 kB
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000080000
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

08048000-0804b000 r-xp 00000000 03:45 160990     /home/rl/nproc/nprocbench
0804b000-0804c000 rw-p 00002000 03:45 160990     /home/rl/nproc/nprocbench
0804c000-0806d000 rw-p 0804c000 00:00 0 
40000000-40013000 r-xp 00000000 03:42 11356336   /lib/ld-2.3.3.so
40013000-40014000 rw-p 00012000 03:42 11356336   /lib/ld-2.3.3.so
40014000-40015000 rw-p 40014000 00:00 0 
40032000-4013c000 r-xp 00000000 03:42 11356337   /lib/libc-2.3.3.so
4013c000-40140000 rw-p 00109000 03:42 11356337   /lib/libc-2.3.3.so
40140000-40142000 rw-p 40140000 00:00 0 
bfffc000-c0000000 rw-p bfffc000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 
