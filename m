Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282906AbRLQVcv>; Mon, 17 Dec 2001 16:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbRLQVcc>; Mon, 17 Dec 2001 16:32:32 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:61912 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S282893AbRLQVc1>;
	Mon, 17 Dec 2001 16:32:27 -0500
Message-ID: <3C1E6462.8060304@arpacoop.it>
Date: Mon, 17 Dec 2001 22:32:18 +0100
From: Carl Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1 - Cannot mount Hpfs partitions, cdroms, shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have ext2/, Fat16, Hpfs, Ntfs and reiserfs partitions on several
disks on a SuSE 6.3 system.
With kernel 2.5.1 I cannot mount Hpfs partitions, the
others work. See attached boot.msg.

At shutdown the system stops at the message: Sending TERM signal to 
applications (or something of the like), just before unmounting. Power 
off solves the problem.

I still can't mount data cdroms, as in pre8-pre11, but the system does 
not lock-up and require a power cycle. The mount fails nicely with the 
generic error message "Wrong fs type, device already mounted, etc..."

Back to 2.5.0



 > <6>Adding Swap: 136512k swap-space (priority -1)
 > <6>Adding Swap: 128484k swap-space (priority -2)
 > <4>invalid operand: 0000
 > <4>CPU:    0
 > <4>EIP:    0010:[grow_buffers+80/256]    Not tainted
 > <4>EFLAGS: 00010286
 > <4>eax: fffffe00   ebx: 00000305   ecx: c035b5a0   edx: 00000200
 > <4>esi: 00000000   edi: 00000305   ebp: 00000000   esp: cfa9ddd8
 > <4>ds: 0018   es: 0018   ss: 0018
 > <4>Process mount (pid: 24, stackpage=cfa9d000)
 > <4>Stack: 00000305 00000000 00000000 00000000 000025a0 c0134257 
00000305 00000000
 > <4> 00000000 cfa9de70 c158dc00 cfe4a280 c0134448 00000305 00000000 
00000000
 > <4> 00000200 c016a48c 00000305 00000000 00000000 cfa3f000 c01734cd 
c158dc00
 > <4>Call Trace: [getblk+39/64] [bread+24/112] [hpfs_map_sector+28/64] 
[hpfs_read_super+349/1840] [insert_super+57/64]
 > <4> [get_sb_bdev+510/624] [do_kern_mount+171/320] 
[do_add_mount+33/208] [do_mount+338/368] [copy_mount_options+77/160] 
[sys_mount+132/208]
 > <4> [system_call+51/56]
 > <4>
 > <4>Code: 0f 0b b9 ff ff ff ff 89 fa 66 c1 ea 08 89 fb b7 00 8b 44 24
 > Kernel logging (ksyslog) stopped.
 > Kernel log daemon terminating.
 >



