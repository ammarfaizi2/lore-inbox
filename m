Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWEUIh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWEUIh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWEUIh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:37:28 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:20920 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751509AbWEUIh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:37:28 -0400
Message-ID: <010801c67cb1$bc13fd00$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 10:37:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 10:16 AM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 10:10:13AM +0200, Haar J?nos wrote:
>
> > This server have 2GB ram, and ~1.1G always free!
> > Anybody have an idea?
>
> you ran out of lowmem?
>
> what kernel is this and how do you trigger it?

I have 4 disk nodes that acts as nbd-server.

The only processes:

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:12 init [3]
    2 ?        SW     0:00 [migration/0]
    3 ?        SWN    0:19 [ksoftirqd/0]
    4 ?        SW     0:00 [migration/1]
    5 ?        SWN    0:03 [ksoftirqd/1]
    6 ?        SW<    0:00 [events/0]
    7 ?        SW<    0:00 [events/1]
    8 ?        SW<    0:00 [khelper]
    9 ?        SW<    0:00 [kthread]
   12 ?        SW<    0:07  \_ [kblockd/0]
   13 ?        SW<    0:02  \_ [kblockd/1]
   14 ?        SW<    0:00  \_ [kacpid]
  101 ?        SW<    0:00  \_ [khubd]
  103 ?        SW<    0:00  \_ [kseriod]
  247 ?        SW    12:09  \_ [pdflush]
  248 ?        SW    10:04  \_ [pdflush]
  250 ?        SW<    0:00  \_ [aio/0]
  251 ?        SW<    0:00  \_ [aio/1]
  252 ?        SW<    0:00  \_ [xfslogd/0]
  253 ?        SW<    0:00  \_ [xfslogd/1]
  254 ?        SW<    0:00  \_ [xfsdatad/0]
  255 ?        SW<    0:00  \_ [xfsdatad/1]
  921 ?        SW<    0:00  \_ [ata/0]
  922 ?        SW<    0:00  \_ [ata/1]
  926 ?        SW<    0:00  \_ [scsi_eh_0]
  927 ?        SW<    0:00  \_ [scsi_eh_1]
  935 ?        SW<    0:00  \_ [scsi_eh_2]
  936 ?        SW<    0:00  \_ [scsi_eh_3]
  937 ?        SW<    0:00  \_ [scsi_eh_4]
  938 ?        SW<    0:00  \_ [scsi_eh_5]
  951 ?        SW<    0:00  \_ [scsi_eh_6]
  952 ?        SW<    0:00  \_ [scsi_eh_7]
 1045 ?        SW<    0:00  \_ [exec-osm/0]
 1047 ?        SW<    0:00  \_ [exec-osm/1]
 1088 ?        SW<    0:00  \_ [kcryptd/0]
 1089 ?        SW<    0:00  \_ [kcryptd/1]
 1090 ?        SW<    0:00  \_ [kmpathd/0]
 1091 ?        SW<    0:00  \_ [kmpathd/1]
 1092 ?        SW<    0:00  \_ [kmirrord]
 1093 ?        SW<    0:14  \_ [kedac]
 1111 ?        SW<  219:01  \_ [md0_raid5]
 1112 ?        SW<    0:23  \_ [rpciod/0]
 1113 ?        SW<    0:00  \_ [rpciod/1]
  249 ?        SW    51:30 [kswapd0]
 2532 ?        S      0:05 syslogd -m 0
 2536 ?        S      0:00 klogd -x
 2615 ?        S      0:00 /usr/sbin/sshd
21484 ?        S      0:00  \_ /usr/sbin/sshd
21486 pts/2    S      0:00      \_ -bash
22444 pts/2    R      0:00          \_ ps fax
 2629 ?        S      0:03 crond
 2638 ?        S      0:55 /bin/bwbar --text-file
/mnt/DY_SYSTEM/sysinfo/st4-eth0_o.php --png-file
/mnt/DY_SYSTEM/sysinfo/st4-eth0_o.png eth0 100 -x 300
 2639 ?        S      0:54 /bin/bwbar --text-file
/mnt/DY_SYSTEM/sysinfo/st4-eth0_i.php -i --png-file
/mnt/DY_SYSTEM/sysinfo/st4-eth0_i.png eth0 100 -x 300
 2674 tty2     S      0:00 /sbin/mingetty tty2
 2675 tty3     S      0:00 /sbin/mingetty tty3
 2676 tty4     S      0:00 /sbin/mingetty tty4
 2677 tty5     S      0:00 /sbin/mingetty tty5
 2678 tty6     S      0:00 /sbin/mingetty tty6
 2925 tty1     S      0:00 /sbin/mingetty tty1 --noclear
 5167 ?        SW     0:00 [lockd]
21290 ?        S<     0:00 /usr/local/bin/nbd-server 1230 /dev/md0
21780 ?        S<     0:38  \_ /usr/local/bin/nbd-server 1230 /dev/md0

The kernel :  2.6.17-rc3-git1, but if i have right, the 2.6.16.1 is the same
if i try to swich back. :-)

2 of 4 nodes frequently reboots without any error message.
I have turned on some debug option, and catch this message.

At this point i watch the free -l -s 1, and i can see, the nbd-server (or
kernel) didn't use the highmem for buffer cache, but why?

             total       used       free     shared    buffers     cached
Mem:       2073048     893360    1179688          0     829092      19820
Low:        893464     868352      25112          0          0          0
High:      1179584      25008    1154576          0          0          0
-/+ buffers/cache:      44448    2028600
Swap:            0          0          0

(min_free_kbytes = 16000 now.)

Cheers,
Janos

