Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272225AbTHIBTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHIBTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:19:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4881 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272167AbTHIBTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:19:30 -0400
Date: Sat, 9 Aug 2003 02:19:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6test /proc/net/pnp oops.
Message-ID: <20030809011901.GA16007@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst trying to figure out what kept changing the bootserver
entry every few minutes, I got the following oops when I did
cat /proc/net/pnp
This is from bitkeeper tree as of 24hrs ago.

		Dave

Unable to handle kernel paging request at virtual address c06f977c
 printing eip:
c04f22aa
*pde = 00103027
*pte = 006f9000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c04f22aa>]    Not tainted
EFLAGS: 00210202
EIP is at pnp_get_info+0xc6/0x17b
eax: 00000013   ebx: ca5fd000   ecx: c05ea6c4   edx: c05ea6c3
esi: 00000003   edi: ca5fd009   ebp: c7fbff24   esp: c7fbfefc
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 16022, threadinfo=c7fbe000 task=c2c38000)
Stack: ca5fd02e c05ea6ad 00000000 00000000 00000000 00000000 00000041 00000000 
       00000400 0804c038 c7fbff6c c0194b9e ca5fd000 c7fbff5c 00000000 00000400 
       3f344b5d 14163598 3f344b5d 14163598 cdcffc80 00000000 ca5fd000 00000000 
Call Trace:
 [<c0194b9e>] proc_file_read+0x259/0x26f
 [<c015feaf>] vfs_read+0xa1/0x10c
 [<c0160119>] sys_read+0x3f/0x5d
 [<c0109623>] syscall_call+0x7/0xb

Code: 83 3d 7c 97 6f c0 ff 74 45 0f b6 05 7f 97 6f c0 8b 55 f0 c7 

