Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSL3QkZ>; Mon, 30 Dec 2002 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSL3QkZ>; Mon, 30 Dec 2002 11:40:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12673 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S266997AbSL3QkX>;
	Mon, 30 Dec 2002 11:40:23 -0500
Date: Sun, 29 Dec 2002 20:58:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench - 25% drop in IPC rates
Message-ID: <Pine.LNX.4.44.0212292052190.1144-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In these results, note that the IPC by signal and by SysV message queue 
are down by ~25%. Something changed. Everything dropped a little, but 
those two really fell off.

As always, "uni" is a single CPU, smp is dual CPU, nosmp is an smp kernel 
running on one processor. All smp kernels show more variation between high 
and low than uni.

I am considering running with preempt on for these, but I have no historic 
data for earlier kernels. Unless it really seems useful, I won't bother 
building yet another kernel.


================================================================
    Run information
================================================================

Run: 2.5.50nosmp-bl
  CPU_MHz              498.049
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.50smp
  Ncpu                 1
Run: 2.5.50smp-bl
  CPU_MHz              497.898
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.50smp
  Ncpu                 2
Run: 2.5.50uni-bl
  CPU_MHz              497.953
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.50
  Ncpu                 1
Run: 2.5.52nosmp-bl
  CPU_MHz              497.929
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.52smp
  Ncpu                 1
Run: 2.5.52smp-bl
  CPU_MHz              497.934
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.52smp
  Ncpu                 2
Run: 2.5.52uni-bl
  CPU_MHz              497.965
  CPUtype              Celeron (Mendocino)
  HostName             bilbo.tmr.com
  KernelName           2.5.52
  Ncpu                 1


================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average
  2.5.50nosmp-bl          51675      56403      54818
  2.5.50smp-bl             8841      55534      38632
  2.5.50uni-bl            66374      66536      66434
  2.5.52nosmp-bl          40230      40322      40264
  2.5.52smp-bl            26179      39434      32565
  2.5.52uni-bl            49606      50246      49939

                                   loops/sec
message queue               low       high    average
  2.5.50nosmp-bl         104965     105261     105105
  2.5.50smp-bl            46184     104640      71925
  2.5.50uni-bl           121383     122357     121851
  2.5.52nosmp-bl          78717      78841      78763
  2.5.52smp-bl            47748      63108      53837
  2.5.52uni-bl            93991      94909      94352

                                   loops/sec
pipes                       low       high    average
  2.5.50nosmp-bl          81211      81529      81411
  2.5.50smp-bl            42573      70910      56900
  2.5.50uni-bl           127910     129669     128603
  2.5.52nosmp-bl          76852      77215      77026
  2.5.52smp-bl            49571      63707      57279
  2.5.52uni-bl           111056     115477     113687

                                   loops/sec
semiphore                   low       high    average
  2.5.50nosmp-bl         110582     112044     111450
  2.5.50smp-bl            54085      78742      63654
  2.5.50uni-bl           131425     132274     131794
  2.5.52nosmp-bl         102732     103045     102924
  2.5.52smp-bl            45872      70347      55434
  2.5.52uni-bl           119345     130644     126665

                                   loops/sec
spin+yield                  low       high    average
  2.5.50nosmp-bl         252055     252529     252361
  2.5.50smp-bl           244146     344592     279022
  2.5.50uni-bl           322742     325100     323594
  2.5.52nosmp-bl         240059     240287     240149
  2.5.52smp-bl           359924     435936     389357
  2.5.52uni-bl           315797     317316     316650

                                   loops/sec
spinlock                    low       high    average
  2.5.50nosmp-bl              3          3          3
  2.5.50smp-bl          1194785    1194882    1194841
  2.5.50uni-bl                3          3          3
  2.5.52nosmp-bl              3          3          3
  2.5.52smp-bl          1194666    1195555    1195141
  2.5.52uni-bl                3          3          3


-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


