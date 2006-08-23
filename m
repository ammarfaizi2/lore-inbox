Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWHWO2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWHWO2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWHWO2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:28:54 -0400
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:9744
	"EHLO mx.hindley.org.uk") by vger.kernel.org with ESMTP
	id S964900AbWHWO2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:28:53 -0400
Date: Wed, 23 Aug 2006 15:28:46 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1{5,6,7}at least] Multiple cron hang in fork on reboot
Message-ID: <20060823142846.GA28461@hindley.uklinux.net>
References: <20060822115650.GA15907@hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20060822115650.GA15907@hindley.uklinux.net>
User-Agent: Mutt/1.5.9i
From: Mark Hindley <mark@hindley.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just noticed that the trace in the task dump I attached was garbled.
Hope this one is clearer.

Mark

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="task.dump"

 schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D C49A3EE4     0  5110   3591  5111    5423  4977 (NOTLB)
       c49a3f0c ffffffff c90425b0 c49a3ee4 c0268d8e c49a3f0c c011642c 00000001 
       00000001 c7d47050 00000000 590c6640 000f42f7 c90425b0 c90426b8 c49a3f84 
       c49a2000 c49a3f48 c49a3f60 c0268e25 00000000 c90425b0 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  5111   5110                     (NOTLB)
       c70d3b50 00000020 c70d3b20 c024e109 c6e84a30 6951ee40 000f44e0 00000000 
       00000000 c0e8ead0 00000000 1c783500 000f4550 c225d030 c225d138 7fffffff 
       00000000 00000000 c70d3b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 00285AB6     0  5423   3591  5426    5424  5110 (NOTLB)
       c71a5f0c c1159560 cae54b80 00285ab6 00000001 c71a5f0c c011642c c71a5ef8 
       00000001 cae54a70 00000000 3cc0e380 000f433d c9725a90 c9725b98 c71a5f84 
       c71a4000 c71a5f48 c71a5f60 c0268e25 00000000 c9725a90 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          D 002859BE     0  5424   3591  5425    5920  5423 (NOTLB)
       c1a9df0c cbeed4b0 c6e84b40 002859be 00000001 35013f00 000f433d 00000000 
       00000000 cbc56090 00000000 35013f00 000f433d c9725590 c9725698 c1a9df84 
       c1a9c000 c1a9df48 c1a9df60 c0268e25 00000000 c9725590 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  5425   5424                     (NOTLB)
       c82afb50 00000020 c82afb20 c024e109 cae54a70 1c783500 000f4550 00000000 
       00000000 c225d030 00000000 1c783500 000f4550 c6e84a30 c6e84b38 7fffffff 
       00000000 00000000 c82afb80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          S C8245B20     0  5426   5423                     (NOTLB)
       c8245b50 c4dc0dc4 00000020 c8245b20 c6e84530 1c783500 000f4550 00000000 
       00000000 c6e84a30 00000000 1c783500 000f4550 cae54a70 cae54b78 7fffffff 
       00000000 00000000 c8245b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 0036EBEC     0  5920   3591  5921    6351  5424 (NOTLB)
       c9bebf0c c1159560 c6e84640 0036ebec 00000001 c9bebf0c c011642c c9bebef8 
       00000001 c6e84530 00000000 e362d1c0 000f43ac c1b7fad0 c1b7fbd8 c9bebf84 
       c9bea000 c9bebf48 c9bebf60 c0268e25 00000000 c1b7fad0 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  5921   5920                     (NOTLB)
       cb315b50 00000020 cb315b20 c024e109 cae54570 1c783500 000f4550 00000000 
       00000000 cae54a70 00000000 1c783500 000f4550 c6e84530 c6e84638 7fffffff 
       00000000 00000000 cb315b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 0043A71E     0  6351   3591  6357    6352  5920 (NOTLB)
       cb479f0c c1159560 c9f1b1c0 0043a71e 00000001 cb479f0c c011642c cb479ef8 
       00000001 c225d530 0001e848 bfd07340 000f440e c225da30 c225db38 cb479f84 
       cb478000 cb479f48 cb479f60 c0268e25 00000000 c225da30 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          D 0043A71E     0  6352   3591  6358    6353  6351 (NOTLB)
       c7e2ff0c c1159560 c9f1b6c0 0043a71e 00000001 c7e2ff0c c011642c c7e2fef8 
       00000001 c9f1b0b0 00000000 bfd07340 000f440e c225d530 c225d638 c7e2ff84 
       c7e2e000 c7e2ff48 c7e2ff60 c0268e25 00000000 c225d530 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          D 0043A6B6     0  6353   3591  6356    6479  6352 (NOTLB)
       c8103f0c cbeed4b0 cae54680 0043a6b6 00000001 c8103f0c c011642c c8103ef8 
       00000001 cae54570 00000000 bc5b70c0 000f440e c76b6050 c76b6158 c8103f84 
       c8102000 c8103f48 c8103f60 c0268e25 00000000 c76b6050 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  6356   6353                     (NOTLB)
       c52c9b50 00000020 c52c9b20 c024e109 c9f1b0b0 1c783500 000f4550 00000000 
       00000000 c6e84530 00000000 1c783500 000f4550 cae54570 cae54678 7fffffff 
       00000000 00000000 c52c9b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          S C024E109     0  6357   6351                     (NOTLB)
       c8a9db50 00000020 c8a9db20 c024e109 c9f1b5b0 1c783500 000f4550 00000000 
       00000000 cae54570 00000000 1c783500 000f4550 c9f1b0b0 c9f1b1b8 7fffffff 
       00000000 00000000 c8a9db80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          S C024E109     0  6358   6352                     (NOTLB)
       ca03db50 00000020 ca03db20 c024e109 c9cb4550 1c783500 000f4550 00000000 
       00000000 c9f1b0b0 00000000 1c783500 000f4550 c9f1b5b0 c9f1b6b8 7fffffff 
       00000000 00000000 ca03db80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 00474DD8     0  6479   3591  6481    6480  6353 (NOTLB)
       c879df0c cbe4aaf4 c9cb4660 00474dd8 00000001 a4271600 000f442a 004c4b40 
       00000000 c9cb4a50 00000000 a4271600 000f442a c6e84030 c6e84138 c879df84 
       c879c000 c879df48 c879df60 c0268e25 00000000 c6e84030 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          D 000000D0     0  6480   3591  6482    6672  6479 (NOTLB)
       c82b9f0c cbeedc60 00000001 000000d0 00000000 a4a12800 000f442a 002dc6c0 
       00000000 c9cb4550 00000000 a4a12800 000f442a c9cb4a50 c9cb4b58 c82b9f84 
       c82b8000 c82b9f48 c82b9f60 c0268e25 00000000 c9cb4a50 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  6481   6479                     (NOTLB)
       c72a5b50 00000020 c72a5b20 c024e109 c9cb4050 1c783500 000f4550 00000000 
       00000000 c9f1b5b0 00000000 1c783500 000f4550 c9cb4550 c9cb4658 7fffffff 
       00000000 00000000 c72a5b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          S C86FDB20     0  6482   6480                     (NOTLB)
       c86fdb50 ca702104 00000020 c86fdb20 c7e53a70 1c783500 000f4550 00000000 
       00000000 c9cb4550 00000000 1c783500 000f4550 c9cb4050 c9cb4158 7fffffff 
       00000000 00000000 c86fdb80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 004CC0B0     0  6672   3591  6673    6902  6480 (NOTLB)
       c4bf9f0c 1ab763ca c7e53b80 004cc0b0 00000001 c4bf9f0c c011642c c4bf9ef8 
       00000001 c7e53a70 00022e09 8e5c11c0 000f4454 c7e53070 c7e53178 c4bf9f84 
       c4bf8000 c4bf9f48 c4bf9f60 c0268e25 00000000 c7e53070 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  6673   6672                     (NOTLB)
       c7c3db50 00000020 c7c3db20 c024e109 c957aa30 1c783500 000f4550 00000000 
       00000000 c9cb4050 00000000 1c783500 000f4550 c7e53a70 c7e53b78 7fffffff 
       00000000 00000000 c7c3db80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 0051EB36     0  6902   3591  6903    6967  6672 (NOTLB)
       c1685f0c c1159560 c957ab40 0051eb36 00000001 c1685f0c c011642c c1685ef8 
       00000001 c957aa30 00000000 8d7ce340 000f447e c72c50d0 c72c51d8 c1685f84 
       c1684000 c1685f48 c1685f60 c0268e25 00000000 c72c50d0 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  6903   6902                     (NOTLB)
       c735fb50 00000020 c735fb20 c024e109 c7e53570 1c783500 000f4550 00000000 
       00000000 c7e53a70 00000000 1c783500 000f4550 c957aa30 c957ab38 7fffffff 
       00000000 00000000 c735fb80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 0053B800     0  6967   3591  6968    7396  6902 (NOTLB)
       c19a3f0c c1159560 c7e53680 0053b800 00000001 83529f00 000f448c 00000000 
       00000000 cbc56090 00000000 83529f00 000f448c c72f1a90 c72f1b98 c19a3f84 
       c19a2000 c19a3f48 c19a3f60 c0268e25 00000000 c72f1a90 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  6968   6967                     (NOTLB)
       c0617b50 00000020 c0617b20 c024e109 c4922a70 1c783500 000f4550 00000000 
       00000000 c957aa30 00000000 1c783500 000f4550 c7e53570 c7e53678 7fffffff 
       00000000 00000000 c0617b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 005E7220     0  7396   3591  7399    7397  6967 (NOTLB)
       c8a65f0c c1159560 c4922180 005e7220 00000001 c8a65f0c c011642c c8a65ef8 
       00000001 c4922070 0001e848 632e4680 000f44e0 c72f1590 c72f1698 c8a65f84 
       c8a64000 c8a65f48 c8a65f60 c0268e25 00000000 c72f1590 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          D 005E720C     0  7397   3591  7398    7560  7396 (NOTLB)
       c7f5ff0c c1159560 c4922b80 005e720c 00000001 c7f5ff0c c011642c c7f5fef8 
       00000001 c4922a70 00000000 6295b000 000f44e0 c4922570 c4922678 c7f5ff84 
       c7f5e000 c7f5ff48 c7f5ff60 c0268e25 00000000 c4922570 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  7398   7397                     (NOTLB)
       c8a91b50 00000020 c8a91b20 c024e109 c4922070 1c783500 000f4550 00000000 
       00000000 c7e53570 00000000 1c783500 000f4550 c4922a70 c4922b78 7fffffff 
       00000000 00000000 c8a91b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          S CA775B20     0  7399   7396                     (NOTLB)
       ca775b50 c9f0dda4 00000020 ca775b20 c9e8ea30 1c783500 000f4550 00000000 
       00000000 c4922a70 00000000 1c783500 000f4550 c4922070 c4922178 7fffffff 
       00000000 00000000 ca775b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 0062014E     0  7560   3591  7561    7992  7397 (NOTLB)
       cafa3f0c c1159560 c9e8eb40 0062014e 00000001 cafa3f0c c011642c cafa3ef8 
       00000001 c9e8ea30 00000000 43b45940 000f44fc c9a46090 c9a46198 cafa3f84 
       cafa2000 cafa3f48 cafa3f60 c0268e25 00000000 c9a46090 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  7561   7560                     (NOTLB)
       c237fb50 00000020 c237fb20 c024e109 c9725090 1c783500 000f4550 00000000 
       00000000 c4922070 00000000 1c783500 000f4550 c9e8ea30 c9e8eb38 7fffffff 
       00000000 00000000 c237fb80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 
cron          D 006CEF94     0  7992   3591  7993          7560 (NOTLB)
       c4993f0c c1159560 c0e8ebe0 006cef94 00000001 c4993f0c c011642c c4993ef8 
       00000001 c0e8ead0 00000000 1c68f2c0 000f4550 c72c55d0 c72c56d8 c4993f84 
       c4992000 c4993f48 c4993f60 c0268e25 00000000 c72c55d0 c0114e24 00000000 
Call Trace:
 <c0268e25> wait_for_completion+0x80/0xc3  <c011751e> do_fork+0x140/0x170
 <c0101aa9> sys_vfork+0x19/0x1b  <c0102b97> syscall_call+0x7/0xb
cron          S C024E109     0  7993   7992                     (NOTLB)
       c03c7b50 00000020 c03c7b20 c024e109 c7f97160 c86f2f24 c03c7b4c c024e8de 
       8ce42d00 c708d070 00000000 1c783500 000f4550 c0e8ead0 c0e8ebd8 7fffffff 
       00000000 00000000 c03c7b80 c026947c c0246cc5 00000000 0000c4b0 00000000 
Call Trace:
 <c026947c> schedule_timeout+0x16/0x91  <c015c979> do_select+0x383/0x3d2
 <c015cc14> core_sys_select+0x24c/0x30e  <c015cd66> sys_select+0x90/0x13d
 <c0102b97> syscall_call+0x7/0xb 

--0F1p//8PRICkK4MW--
