Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTASRvF>; Sun, 19 Jan 2003 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbTASRvF>; Sun, 19 Jan 2003 12:51:05 -0500
Received: from ip-204-97-176-11.modem.logical.net ([204.97.176.11]:63879 "EHLO
	manoir.bloodwolf.org") by vger.kernel.org with ESMTP
	id <S267679AbTASRvE>; Sun, 19 Jan 2003 12:51:04 -0500
Message-ID: <3E2AE7E9.1080804@bloodwolf.org>
Date: Sun, 19 Jan 2003 13:01:13 -0500
From: Christophe Dupre <duprec@bloodwolf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running Red Hat 7.2 with Red Hat's kernel 2.4.18-19.7.x, I  get this 
error whenever there's a lot of disk activity (such as a backup):

kernel BUG at inode.c:565!
invalid operand: 0000
esp cyclades ip_conntrack_ftp eepro10 3c59x ipt_REHECT iptable_nat 
ip_conntrack
iptable_filter ip_tables st ext3 jbd aic7xxx sd_mod scsi_mod
CPI: 0
EIP: 0010:[<c014c689>]   Not tainted
EFLAGS: 00010206

EIP is at clear_inode [kernel] 0x19 (2.4.19-19.7.x)
eax: cb841060   ebx: cb841040   ecx: cb841040   edx: 00000800
esi: c170ffa8   edi: c170e000   ebp: 0000d6a9   esp: c170ff70
ds: 0018  es: 0018  ss: 0018
Process kswapd (pid: 5, stackpage=c170f000)
Cal Trace: [<c014c797>] dispose_list [kernel] 0x47 (0xc170ff7c))
[<c014c790>] dispose_list [kernel] 0x50 (0xc170ff84))
[<c014ca53>] prune_icache [kernel] 0x123 (0xc170ff98))
[<c014ca90>] shrink_icache_memory [kernel] 0x20 (0xc170ffc0))
[<c0131c9d>] kswapd [kernel] 0x30d (0xc170ffc8))
[<c0105000>] stext [kernel] 0x0 (0xc170ffe8))
[<c0107146>] kernel_thread [kernel] 0x26 (0xc170fff0))
[<c0131990>] kswapd [kernel] 0x0 (0xc170fff8))

Code: 0f 0b 35 02 3d e0 22 c0 8b 83 0c 01 00 00 a9 10 00 00 00 75

The tape backup is SCSI connected to an Adaptec 29160. The disk is IDE. 
The filesystem is ext2fs.

Help would be appreciated.

