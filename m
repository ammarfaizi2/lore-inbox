Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIOT32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIOT32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUIOT32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:29:28 -0400
Received: from eh3.com ([66.220.5.62]:5341 "HELO eh3.com") by vger.kernel.org
	with SMTP id S267330AbUIOT3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:29:23 -0400
Subject: Re: 3ware 9500 ("3w-9xxx") w/ dual Opteron (Tyan 2885)
From: Ed Hill <ed@eh3.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409082001.20831.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1094661631.13662.2808.camel@localhost.localdomain>
	 <200409082001.20831.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1095276558.2036.398.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 15:29:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 13:01, Denis Vlasenko wrote:
> On Wednesday 08 September 2004 19:40, Ed Hill wrote:
> > Hi folks,
> >
> > Has anyone managed to get a 3ware 9500-series RAID controller working
> > stably on an SMP Opteron system?  

> Post oopses to the list.


Hi Denis,

Below is an oops from a "vanilla" 2.6.8.1 w/ latest 3ware 2.6 driver
from their web site.  More details are available at:

  http://acesgrid.org/ACESwiki/StorageAdamsAsimov

thanks,
Ed

=== "vanilla" 2.6.8.1 w/ latest 3ware 2.6 driver from their web site ===

Sep  2 19:37:19 adams kernel: Unable to handle kernel paging request at
000003010383a8d0 RIP: 
Sep  2 19:37:19 adams kernel: <ffffffff801349c8>{__wake_up_common+40}
Sep  2 19:37:19 adams kernel: PML4 0 
Sep  2 19:37:19 adams kernel: Oops: 0000 [1] SMP 
Sep  2 19:37:19 adams kernel: CPU 1 
Sep  2 19:37:19 adams kernel: Modules linked in: nfsd exportfs ipv6 parport_pc lp \
  parport autofs4 nfs lockd sunrpc iptable_filter ip_tables tg3 ohci1394 ieee1394 \
  sd_mod dm_mod ohci_hcd button battery asus_acpi ac
Sep  2 19:37:19 adams kernel: Pid: 62, comm: kswapd1 Not tainted 2.6.8.1
Sep  2 19:37:19 adams kernel: RIP: 0010:[<ffffffff801349c8>] <ffffffff801349c8>{__wake_up_common+40}
Sep  2 19:37:19 adams kernel: RSP: 0018:00000101ffee1b88  EFLAGS: 00010006
Sep  2 19:37:19 adams kernel: RAX: 000003010383a8d0 RBX: 000001010383a8c8 RCX: 0000000000000000
Sep  2 19:37:19 adams kernel: RDX: 0000000000000001 RSI: 0000000000000003 RDI: 000001010383a8c8
Sep  2 19:37:19 adams kernel: RBP: 00000101ffee1bb8 R08: 000001010335b0d8 R09: 00000101ffee1ad0
Sep  2 19:37:19 adams kernel: R10: 00000100cd7b4c80 R11: 0000000000000000 R12: 00000101ffee1db8
Sep  2 19:37:19 adams kernel: R13: 0000000000000001 R14: 000001010383a8d0 R15: 000001010335b0d8
Sep  2 19:37:19 adams kernel: FS:  0000002a9557e800(0000) GS:ffffffff80542e80(0000) knlGS:0000000000000000
Sep  2 19:37:19 adams kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Sep  2 19:37:19 adams kernel: CR2: 000003010383a8d0 CR3: 0000000004872000 CR4: 00000000000006e0
Sep  2 19:37:19 adams kernel: Process kswapd1 (pid: 62, threadinfo 00000101ffee0000, task 00000100d9ef33f0)
Sep  2 19:37:19 adams kernel: Stack: 0000000300000000 000001010383a8c8 00000101ffee1db8 00000100d89cce50 
Sep  2 19:37:19 adams kernel:        00000101ffee1e58 0000000000000001 00000101ffee1bd8 ffffffff80134a37 
Sep  2 19:37:19 adams kernel:        0000000000000202 00000100d89cce50 
Sep  2 19:37:19 adams kernel: Call Trace:<ffffffff80134a37>{__wake_up+39} <ffffffff80163834>{shrink_list+1124} 
Sep  2 19:37:19 adams kernel:        <ffffffff80163bb4>{shrink_cache+628} <ffffffff801644e1>{shrink_zone+225} 
Sep  2 19:37:19 adams kernel:        <ffffffff801648fd>{balance_pgdat+493} <ffffffff801365b0>{prepare_to_wait+80} 
Sep  2 19:37:19 adams kernel:        <ffffffff80164afa>{kswapd+282} <ffffffff80136680>{autoremove_wake_function+0} 
Sep  2 19:37:19 adams kernel:        <ffffffff80136680>{autoremove_wake_function+0} <ffffffff80132e31>{schedule_tail+17} 
Sep  2 19:37:19 adams kernel:        <ffffffff80112587>{child_rip+8} <ffffffff8015de60>{pdflush+0} 
Sep  2 19:37:19 adams kernel:        <ffffffff801649e0>{kswapd+0} <ffffffff8011257f>{child_rip+0} 
Sep  2 19:37:19 adams kernel:        
Sep  2 19:37:19 adams kernel: 
Sep  2 19:37:19 adams kernel: Code: 4c 8b 20 74 30 66 66 90 48 8d 78 e8 8b 58 e8 4c 89 f9 8b 55 
Sep  2 19:37:19 adams kernel: RIP <ffffffff801349c8>{__wake_up_common+40} RSP <00000101ffee1b88>
Sep  2 19:37:19 adams kernel: CR2: 000003010383a8d0

-- 
Edward H. Hill III, PhD
office:  MIT Dept. of EAPS;  Rm 54-1424;  77 Massachusetts Ave.
             Cambridge, MA 02139-4307
emails:  eh3@mit.edu                ed@eh3.com
URLs:    http://web.mit.edu/eh3/    http://eh3.com/
phone:   617-253-0098
fax:     617-253-4464

