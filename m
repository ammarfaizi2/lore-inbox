Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTFDUhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTFDUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:35:05 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33224
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264043AbTFDUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:34:38 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 16:50:53 -0400
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <20030604120932.GS3412@x30.school.suse.de> <20030604122015.GR4853@suse.de>
In-Reply-To: <20030604122015.GR4853@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tul3+rLKexskjIc"
Message-Id: <200306041650.53030.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tul3+rLKexskjIc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 04 June 2003 08:20, Jens Axboe wrote:
> On Wed, Jun 04 2003, Andrea Arcangeli wrote:
> > On Wed, Jun 04, 2003 at 02:00:53PM +0200, Jens Axboe wrote:
> > > since you have a single writer and maybe a reader or two. The single
> > > writer cannot starve anyone else.
> >
> > unless you're changing an atime and you've to mark_buffer_dirty or
> > similar (balance_dirty will write stuff the same way from cp and the
> > reader then).
>
> Yes you are right, could be.
>
> But the whole thing still smells fishy. Read starvation causing mouse
> stalls, hmm.

If reads from swap get starved, you can have interactive dropouts in just 
about anything.

My desktop is usually pretty deep into swap.  I upgrade to machines with four 
times as much memory, but that usually means the graphics resolution went up 
and it just lets me keep more windows open in more desktops.  (Currently 
six.)

My record was driving the system so deep into swapping frenzy it was still 
swapping when I came back from lunch.  Really.  This was under 2.4.4, though.  
On RH 9/2.4.20-? my record is a little under five minutes of "frozen 
thrashing on swap" before I got control of the system back.  That's just a 
"go for a soda" break.  And at least the mouse cursor never froze for more 
than a couple seconds at a time during that, even if the desktop was ignoring 
me... :)

Haven't tried 2.5 on anything but servers yet, but it's on my to-do list...

Rob

(I am the VM subsystem's worst nightmare.  Bwahaha.)
--Boundary-00=_tul3+rLKexskjIc
Content-Type: text/plain;
  charset="iso-8859-1";
  name="typescript"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="typescript"

Script started on Wed 04 Jun 2003 04:25:29 PM EDT
]0;landley@localhost:~[landley@localhost landley]$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  261390336 247234560 14155776        0  9351168 80461824
Swap: 542859264 276152320 266706944
MemTotal:       255264 kB
MemFree:         13824 kB
MemShared:           0 kB
Buffers:          9132 kB
Cached:          43372 kB
SwapCached:      35204 kB
Active:         182324 kB
ActiveAnon:     131940 kB
ActiveCache:     50384 kB
Inact_dirty:     19164 kB
Inact_laundry:   14400 kB
Inact_clean:      3512 kB
Inact_target:    43880 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255264 kB
LowFree:         13824 kB
SwapTotal:      530136 kB
SwapFree:       260456 kB
]0;landley@localhost:~[landley@localhost landley]$ cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            65     70    108    2    2    1
ip_fib_hash           11    112     32    1    1    1
urb_priv               0      0     64    0    0    1
journal_head          57    770     48    1   10    1
revoke_table           2    250     12    1    1    1
revoke_record          0    112     32    0    1    1
clip_arp_cache         0      0    128    0    0    1
ip_mrt_cache           0      0    128    0    0    1
tcp_tw_bucket          0     90    128    0    3    1
tcp_bind_bucket        4    224     32    1    2    1
tcp_open_request       0     30    128    0    1    1
inet_peer_cache        0     58     64    0    1    1
ip_dst_cache           5     75    256    1    5    1
arp_cache              2     30    128    1    1    1
blkdev_requests      256    270    128    9    9    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        0     41     92    0    1    1
fasync_cache           2    200     16    1    1    1
uid_cache              2    112     32    1    1    1
skbuff_head_cache    176   2265    256   32  151    1
sock                 589    720   1280  220  240    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            26    232     64    2    4    1
bdev_cache             4     58     64    1    1    1
mnt_cache             13     58     64    1    1    1
inode_cache         2395   3647    512  519  521    1
dentry_cache        2477   4050    128  135  135    1
dquot                  0      0    128    0    0    1
filp                2364   2370    128   79   79    1
names_cache            0     14   4096    0   14    1
buffer_head        16649  30360    128  789 1012    1
mm_struct            173    210    256   14   14    1
vm_area_struct      5840   7770    128  238  259    1
fs_cache              78    116     64    2    2    1
files_cache           78    112    512   15   16    1
signal_cache         243    290     64    5    5    1
sighand_cache        235    253   1408   22   23    4
task_struct            0      0   1792    0    0    1
pte_chain           1958   7590    128   83  253    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0     16  16384    0   16    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4     19   8192    4   19    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             35     75   4096   35   75    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              8     86   2048    5   43    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             59    124   1024   18   31    1
size-512(DMA)          0      0    512    0    0    1
size-512              43    200    512   11   25    1
size-256(DMA)          0      0    256    0    0    1
size-256              43   1200    256    8   80    1
size-128(DMA)          1     30    128    1    1    1
size-128             707   3240    128   33  108    1
size-64(DMA)           0      0    128    0    0    1
size-64              377   1170    128   30   39    1
size-32(DMA)          17     58     64    1    1    1
size-32              397    754     64   10   13    1
]0;landley@localhost:~[landley@localhost landley]$ 
Script done on Wed 04 Jun 2003 04:25:42 PM EDT

--Boundary-00=_tul3+rLKexskjIc--

