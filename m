Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbTGIF13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 01:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbTGIF13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 01:27:29 -0400
Received: from holomorphy.com ([66.224.33.161]:55976 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265686AbTGIF1M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 01:27:12 -0400
Date: Tue, 8 Jul 2003 22:43:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030709054307.GL15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain> <55580000.1057727591@[10.10.2.4]> <20030709051941.GK15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030709051941.GK15452@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 10:13:12PM -0700, Martin J. Bligh wrote:
>> I presume this was for -bk something as it applies clean to -bk6, but not
>> virgin. 
>> However, it crashes before console_init on NUMA ;-( I'll shove early printk
>> in there later.

On Tue, Jul 08, 2003 at 10:19:41PM -0700, William Lee Irwin III wrote:
> Don't worry, I'm debugging it.

Rather predictably, the NUMA KVA remapping shat itself:


Script started on Tue Jul  8 22:28:53 2003
$ sscreen -x
[?1049h[r[H[?7h[?1;4;6l[4l[?1h=(B[1;27r[H[HRecovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting internet superserver: inetd.
Starting printer spooler: lpd.
Starting network benchmark server: netserver.
Not starting NFS kernel daemon: No exports.
Starting OpenBSD Secure Shell server: sshd.
Starting the system activity data collector: sadc.
Starting NFS common utilities: statd lockd.
Starting periodic command scheduler: cron.

Debian GNU/Linux testing/unstable megeira ttyS0

megeira login: root
Password:
Last login: Tue Jul  8 21:56:18 2003 on ttyS0
Linux megeira 2.5.74 #1 SMP Mon Jul 7 22:15:57 PDT 2003 i686 GNU/Linux
megeira:~# mount /mnt/g
megeira:~# !ec
echo 1 > /proc/sys/vm/overcommit_memory ; echo 1 > /proc/sys/vm/swappiness ; echo 360000 > /proc/sys/vm/dirty_expire_centisecs ; echo 360000 > /proc/sys/vm/dirty_writeback_centisecs ; echo 99 > /proc/sys/vm/dirty_background_ratio ; echo 1 > /proc/profile
megeira:~# shutdown -h now
[?5hBroadcast message from root (ttyS0) (Tue Jul  8 22:29:37 2003):

The system is going down for system halt NOW!
INIT: INIT: Sending processes the TERM signal
megeira:~# INIT:Stopping periodic command scheduler: cron.
Stopping internet superserver: inetd.
Stopping printer spooler: lpd.
Stopping network benchmark server: netserver.
Stopping OpenBSD Secure Shell server: sshd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Tue Jul  8 22:30:04 PDT 2003.
Stopping NFS common utilities: lockd statd.
Stopping NFS kernel daemon: mountd nfsd.
Unexporting directories for NFS kernel daemon...done.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Stopping portmap daemon: portmap.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces... done.
Deactivating swap... done.
Unmounting local filesystems... mount: proc already mounted
done.
Shutting down devices
Power down.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
[H[H
    GRUB  version 0.92  (639K lower / 3668992K upper memory)

 +-------------------------------------------------------------------------+ 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
+-------------------------------------------------------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.[5;78H  | Boot Safe Kernel                                                        | 
Boot check Kernel                                                       | 
Boot latest kernel                                                      | 
boot latest kernel from elm3b96                                         | 
2.5.44                                                                  | 
2.5.44-mm4                                                              | 
2.5.44-mm4-erich                                                        | 
2.5.44-mm4-michael                                                      | 
2.5.47-stock                                                            | 
2.5.47-sched                                                            | 
2.5.50-sched                                                            | 
2.5.50-stock                                                            | v[8;3H boot latest kernel from elm3b96                                         [H[H
    GRUB  version 0.92  (639K lower / 3668992K upper memory)

 [ Minimal BASH-like line editing is supported.  For the first word, TAB
   lists possible command completions.  Anywhere else TAB lists the possible
   completions of a device/filename.  ESC at any time exits. ]

grub>                                                                          root (hd0,1)
 Filesystem type is ext2fs, partition type 0x83

grub>                                                                          kernel /home/wli/vmlinuz-ingo root=/dev/sda2 console=ttyS0,38400n8 prof<00n8 profi                                                                    le=1grub> kernel /home/wli/vmlinuz-ingo root=/dev/sda2 console=ttyS0,38400n8 profi>
   [Linux-bzImage, setup=0xa00, size=0x1407e4]

grub>                                                                          boot
Linux version 2.5.74-mm2 (wli@megeira) (gcc version 3.3 (Debian)) #1 SMP Tue Jul 8 22:28:26 PDT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000800000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000e0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000800000000 (usable)
Reserving 23040 pages of KVA for lmem_map of node 1
Shrinking node 1 from 4194304 pages to 4171264 pages
Reserving 23040 pages of KVA for lmem_map of node 2
Shrinking node 2 from 6291456 pages to 6268416 pages
Reserving 23040 pages of KVA for lmem_map of node 3
Shrinking node 3 from 8388608 pages to 8365568 pages
Reserving total of 69120 pages for numa KVA remap
28832MB HIGHMEM available.
3666MB LOWMEM available.
min_low_pfn = 1045, max_low_pfn = 938496, highstart_pfn = 1007616
Low memory ends at vaddr e7200000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f2600000 - f8000000
node 2 will remap to vaddr ecc00000 - f2600000
node 3 will remap to vaddr e7200000 - ecc00000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Unknown interrupt
Un[?1l>[27;1H
[?1049l[detached]
$ 

Script done on Tue Jul  8 22:36:58 2003
