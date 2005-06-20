Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFTAhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFTAhF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVFTAhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:37:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbVFTAg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:36:59 -0400
Date: Sun, 19 Jun 2005 17:36:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
       abhay_salunke@dell.com, matt_domsch@dell.com, greg@kroah.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
 BIOS update driver
Message-Id: <20050619173636.50acad6f.akpm@osdl.org>
In-Reply-To: <20050615175946.GA1495@littleblue.us.dell.com>
References: <20050615175946.GA1495@littleblue.us.dell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch causes my x86_64 box to oops during udev startup:


Starting udev:  Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
<ffffffff801a807c>{sysfs_readdir+350}                                                     
PGD 17be07067 PUD 17add5067 PMD 0    
Oops: 0000 [1] PREEMPT SMP        
CPU 2                      
Modules linked in:
Pid: 27686, comm: udevstart Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a807c>] <ffffffff801a807c>{sysfs_readdir+350}
RSP: 0018:ffff81017adc5ea8  EFLAGS: 00010286                        
RAX: 0000000000000000 RBX: ffff81017ceb18d0 RCX: 0000000000000007
RDX: ffffffff80184516 RSI: ffff81017adc5f38 RDI: ffff81017b45d41c
RBP: ffff81017aa5cd50 R08: 0000000000015bc0 R09: 000000302062d6b8
R10: 000000302062d6b8 R11: 0000000000000246 R12: ffff81017ceb18c8
R13: ffff81017fc663a0 R14: ffff81017edfaa70 R15: ffff81017b45d414
FS:  00002aaaaaadcde0(0000) GS:ffffffff805a0780(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 0000000000000040 CR3: 000000017f2d5000 CR4: 00000000000006e0
Process udevstart (pid: 27686, threadinfo ffff81017adc4000, task ffff81017cb77030)
Stack: 0000000700000246 ffffffff80184516 ffff81017adc5f38 ffff81017edfaa70        
       ffff81017fc67860 00000000fffffffe ffff81017fc67928 ffffffff80184516 
       ffff81017adc5f38 ffffffff8018427a                                   
Call Trace:<ffffffff80184516>{filldir64+0} <ffffffff80184516>{filldir64+0}
       <ffffffff8018427a>{vfs_readdir+126} <ffffffff80184643>{sys_getdents64+116}
       <ffffffff80171969>{sys_close+132} <ffffffff8010d9e2>{system_call+126}     
                                                                            
       
Code: 48 8b 40 40 eb 11 48 8b 3d 4f eb 3d 00 be 02 00 00 00 e8 86 
