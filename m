Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUJQXH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUJQXH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbUJQXH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:07:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:24796 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269316AbUJQXH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:07:26 -0400
Message-ID: <4172F91D.8090109@osdl.org>
Date: Sun, 17 Oct 2004 15:58:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: NMI watchdog detected lockup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing this often during a kernel build on AIC79xx.
I did one kernel build on SATA without seeing this.
This is on a dual-Opteron IBM Workstation A with
2 GB RAM, SATA, & SCSI.

Does this show anything?  (not to me)
Maybe the buggy code is on CPU1 and its registers aren't
captured.


NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0
Modules linked in: aic79xx usbserial aic7xxx ohci1394 ieee1394
Pid: 0, comm: swapper Not tainted 2.6.9-rc4-bk3
RIP: 0010:[<ffffffff8010f5f0>] <ffffffff8010f5f0>{default_idle+32}
RSP: 0018:ffffffff805e3fb8  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
RDX: ffffffff8010f5d0 RSI: ffffffff80472b80 RDI: 0000010001e11b20
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff80562b60 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000002a9670fd40(0000) GS:ffffffff805de880(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000002a9568a2c0 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff805e2000, task 
ffffffff80472b80)
Stack: ffffffff8010f9fd 0000000000000000 ffffffff805e56e5 0000000000000000
        ffffffff8055fc60 0000000000000800 ffffffff805e51e0 
0000000000000404
        0000000000000000
Call Trace:<ffffffff8010f9fd>{cpu_idle+29} 
<ffffffff805e56e5>{start_kernel+421}
        <ffffffff805e51e0>{_sinittext+480}

Code: c3 fb f3 c3 66 66 66 90 66 66 66 90 66 66 66 90 48 83 ec 38
console shuts up ...
  NMI Watchdog detected LOCKUP on CPU1, registers:


-- 
~Randy
