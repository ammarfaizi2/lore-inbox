Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJQRlm>; Thu, 17 Oct 2002 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSJQRlg>; Thu, 17 Oct 2002 13:41:36 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:43287 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S261955AbSJQRlO>; Thu, 17 Oct 2002 13:41:14 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: GrandMasterLee <masterlee@digitalroadkill.net>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Date: Thu, 17 Oct 2002 19:47:03 +0200
User-Agent: KMail/1.4.7
References: <200210152120.13666.simon.roscic@chello.at> <200210161838.39824.simon.roscic@chello.at> <1034824086.32333.29.camel@localhost>
In-Reply-To: <1034824086.32333.29.camel@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210171947.04255.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 05:08, GrandMasterLee <masterlee@digitalroadkill.net> wrote:
> Do you actually get the lockups then?

no, i didn't had any lookups, each of the machines currently have an uptime 
of only 16 day's and that's because we had to shutdown the power in our 
whole company for a half day. 
the best uptime i had was approx 40-50 day's, then i got the following
problem: the lotus domino server processes (not the whole machine) were
freezing every week, but that is a known problem for heavy loaded domino
servers, you have to increase the ammount of ipc memory for java or something 
(of the domino server), and since i did this everything works without problems.

the "primary" lotus domino server also got quite swap happy in the last weeks,
currently he has to serve almost everything that has to do with notes, the 
second server isn't realy in use yet ...

if you are interested, procinfo -a shows this on one of the 3 machines:
(all 3 are the same, except that the "primary" lotus domino server has 2 cpu's
and 2 gb ram, the other 2, have 1 cpu and 1 gb ram)

---------------- procinfo ----------------
Linux 2.4.17-xfs-smp (root@adam-neu) (gcc 2.95.3 20010315 ) #1 2CPU [adam.]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:       2061272     2050784       10488           0        2328     1865288
Swap:      1056124      265652      790472

Bootup: Tue Oct  1 17:42:07 2002    Load average: 0.14 0.08 0.02 1/445 11305

user  :   1d 20:15:32.03   5.7%  page in :1196633058  disk 1:  1670401r  953006w
nice  :       0:00:24.69   0.0%  page out:261985556  disk 2: 27762380r11039499w
system:      13:05:51.19   1.7%  swap in :  5870304  disk 3:        4r       0w
idle  :  29d 18:09:25.15  92.5%  swap out:  5099371  disk 4:        4r       0w
uptime:  16d  1:45:36.53         context :2810591591

irq  0: 138873653 timer                 irq 12:    104970 PS/2 Mouse
irq  1:      5597 keyboard              irq 14:        54 ide0
irq  2:         0 cascade [4]           irq 18:   8659653 ips
irq  3:         1                       irq 20: 421419256 e1000
irq  4:         1                       irq 24:  38444870 qla2200
irq  6:         3                       irq 28:     17728 e100
irq  8:         2 rtc

Kernel Command Line:
  auto BOOT_IMAGE=Linux ro root=803 BOOT_FILE=/boot/vmlinuz

Modules:
 24 *sg               6  lp              25  parport         59 *e100
 48 *e1000          165 *qla2200

Character Devices:                      Block Devices:
  1 mem              10 misc              2 fd
  2 pty              21 sg                3 ide0
  3 ttyp             29 fb                8 sd
  4 ttyS            128 ptm              65 sd
  5 cua             136 pts              66 sd
  6 lp              162 raw
  7 vcs             254 HbaApiDev

File Systems:
[rootfs]            [bdev]              [proc]              [sockfs]
[tmpfs]             [pipefs]            ext3                ext2
[nfs]               [smbfs]             [devpts]            xfs
---------------- procinfo ----------------

the kernel running on the 3 machines is a "vanilla" 2.4.17
plus XFS, plus ext3-0.9.17, plus intel ether express 100 and
and intel ether express 1000 driver (e100 and e1000), and
the qlogic qla2x00 5.36.3 driver ...

i think i will wait for 2.4.20 and then make a new kernel for the 3 machines ...

simon.
(please CC me, i'm not subscribed to lkml)
