Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRI0IgJ>; Thu, 27 Sep 2001 04:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272092AbRI0IgA>; Thu, 27 Sep 2001 04:36:00 -0400
Received: from [195.246.135.25] ([195.246.135.25]:17924 "EHLO
	chert.194.133.98.200") by vger.kernel.org with ESMTP
	id <S272062AbRI0Ifq>; Thu, 27 Sep 2001 04:35:46 -0400
Date: Thu, 27 Sep 2001 12:35:22 +0200
From: Andrei Lahun <Uman@editec-lotteries.com>
To: linux-kernel@vger.kernel.org
Subject: proces stopped in D state for a long time(2.4.10)
Message-ID: <20010927123522.A380@chert.194.133.98.200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a problems with dvd player(xine) with 2.4.10 when i try to search in movie
on of the xine threads stooped in D state for 10-20 second.
Here is trace.
Call Trace: [<c01103a2>] [<c017cfac>] [<c0186f1b>] [<c0187dbf>] [<c0112841>] 
   [<c0187dbf>] [<c018a41e>] [<c018caa1>] [<c017c5b8>] [<c017c612>] [<c013acf2>] 
   [<c013ae59>] [<c0186e30>] [<c0186e30>] [<c018b662>] [<c0141a81>] [<c01309bf>] 
   [<c015dc7c>] [<c0186e30>] [<c017b4c6>] [<c01863ad>] [<c0186e30>] [<c017b4c6>] 
   [<c0186e30>] [<c017b4c6>] [<c01863ad>] [<c0186c80>] [<c018617c>] [<c0186e5c>] 
   [<c0186c80>] [<c01862f5>] [<c011000a>] [<c01103a2>] [<c017cfac>] [<c0186f1b>] 
   [<c0187532>] [<c01874db>] [<c01283ce>] [<c0128116>] [<c011eea1>] [<c011ef2f>] 
   [<c011f027>] [<c010f568>] [<c010f408>] [<c016ec9c>] [<c016ed01>] [<c0133fab>] 
   [<c0188f14>] [<c017ef35>] [<c0141290>] [<c0134dc0>] [<c013b157>] [<c0106b2b>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  xine
>>EIP; c3378000 <___strtok+310c250/85cf250>   <=====
Trace; c01103a2 <wait_for_completion+76/a4>
Trace; c017cfac <ide_do_drive_cmd+100/120>
Trace; c0186f1a <create_proc_ide_interfaces+433e/66f4>
Trace; c0187dbe <create_proc_ide_interfaces+51e2/66f4>
Trace; c0112840 <panic+570/5e0>
Trace; c0187dbe <create_proc_ide_interfaces+51e2/66f4>
Trace; c018a41e <init_cdrom_command+342/9a8>
Trace; c018caa0 <cdrom_mode_select+1fb8/22a8>
Trace; c017c5b8 <ide_wait_stat+378/440>
Trace; c017c612 <ide_wait_stat+3d2/440>
Trace; c013acf2 <page_follow_link+8aa/8f0>
Trace; c013ae58 <__kill_fasync+50/60>
Trace; c0186e30 <create_proc_ide_interfaces+4254/66f4>
Trace; c0186e30 <create_proc_ide_interfaces+4254/66f4>
Trace; c018b662 <cdrom_mode_select+b7a/22a8>
Trace; c0141a80 <is_bad_inode+45c/558>
Trace; c01309be <generic_direct_IO+18a/1e4>
Trace; c015dc7c <batch_entropy_store+220/228>
Trace; c0186e30 <create_proc_ide_interfaces+4254/66f4>
Trace; c017b4c6 <atapi_output_bytes+3e/68>
Trace; c01863ac <create_proc_ide_interfaces+37d0/66f4>
Trace; c0186e30 <create_proc_ide_interfaces+4254/66f4>
Trace; c017b4c6 <atapi_output_bytes+3e/68>
Trace; c0186e30 <create_proc_ide_interfaces+4254/66f4>
Trace; c017b4c6 <atapi_output_bytes+3e/68>
Trace; c01863ac <create_proc_ide_interfaces+37d0/66f4>
Trace; c0186c80 <create_proc_ide_interfaces+40a4/66f4>
Trace; c018617c <create_proc_ide_interfaces+35a0/66f4>
Trace; c0186e5c <create_proc_ide_interfaces+4280/66f4>
Trace; c0186c80 <create_proc_ide_interfaces+40a4/66f4>
Trace; c01862f4 <create_proc_ide_interfaces+3718/66f4>
Trace; c011000a <schedule+25e/394>
Trace; c01103a2 <wait_for_completion+76/a4>
Trace; c017cfac <ide_do_drive_cmd+100/120>
Trace; c0186f1a <create_proc_ide_interfaces+433e/66f4>
Trace; c0187532 <create_proc_ide_interfaces+4956/66f4>
Trace; c01874da <create_proc_ide_interfaces+48fe/66f4>
Trace; c01283ce <__alloc_pages+46/1f8>
Trace; c0128116 <_alloc_pages+16/288>
Trace; c011eea0 <vmtruncate+36c/a0c>
Trace; c011ef2e <vmtruncate+3fa/a0c>
Trace; c011f026 <vmtruncate+4f2/a0c>
Trace; c010f568 <do_BUG+184/6b8>
Trace; c010f408 <do_BUG+24/6b8>
Trace; c016ec9c <generic_make_request+130/140>
Trace; c016ed00 <submit_bh+54/70>
Trace; c0133faa <kern_mount+c82/11b4>
Trace; c0188f14 <create_proc_ide_interfaces+6338/66f4>
Trace; c017ef34 <system_bus_clock+c20/c74>
Trace; c0141290 <update_atime+44/54>
Trace; c0134dc0 <blkdev_put+228/234>
Trace; c013b156 <kill_fasync+2ee/308>
Trace; c0106b2a <__up_wakeup+1046/2254>
I did it when it stopped in D state
Another thread where Ok.
With preemptive patch this delays decreased in 5 10 times but still
not as good as with 2.4.9-ac
Andrei.
