Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTLTMV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLTMV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:21:56 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:30161 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263898AbTLTMVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:21:54 -0500
Message-ID: <3FE43FD9.3010509@free.fr>
Date: Sat, 20 Dec 2003 13:26:01 +0100
From: =?ISO-8859-1?Q?Ga=EBl_Deest?= <GUtopiste@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops while unloading module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I first apologize for my approximative english.

I will soon get a Logitech Quickcam pro 4000, so I compiled my kernel 
with the PWC driver for Philips webcams (built-in). In addition, I tried 
to load the external (and closed-source) pwcx module (without the webcam 
plugged-in, of course). When I wanted to unload it with rmmod, it ended 
with "Segmentation fault" and I got the following Oops :

Dec 20 00:39:56 home kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Dec 20 00:39:56 home kernel:  printing eip:
Dec 20 00:39:56 home kernel: 00000000
Dec 20 00:39:56 home kernel: *pde = 00000000
Dec 20 00:39:56 home kernel: Oops: 0000 [#1]
Dec 20 00:39:56 home kernel: CPU:    0
Dec 20 00:39:56 home kernel: EIP:    0060:[<00000000>]    Tainted: PF
Dec 20 00:39:56 home kernel: EFLAGS: 00210246
Dec 20 00:39:56 home kernel: EIP is at 0x0
Dec 20 00:39:56 home kernel: eax: 00000000   ebx: e1a11d40   ecx: 
00000000   edx: e1a11d40
Dec 20 00:39:56 home kernel: esi: c045f718   edi: 00000000   ebp: 
00000880   esp: c2fadf5c
Dec 20 00:39:56 home kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 00:39:56 home kernel: Process rmmod (pid: 13771, 
threadinfo=c2fac000 task=cfd4e040)
Dec 20 00:39:56 home kernel: Stack: c0133549 e1a11d40 bffff7b0 0000003b 
00000000 78637770 40016000 c0147787
Dec 20 00:39:56 home kernel:        df571100 c7da6700 c2454e80 40016000 
40017000 40017000 c2454e80 df571100
Dec 20 00:39:56 home kernel:        df571120 00000000 c2fac000 00147814 
df571100 bffff7b0 bffff7b0 00000880
Dec 20 00:39:56 home kernel: Call Trace:
Dec 20 00:39:56 home kernel:  [<c0133549>] sys_delete_module+0x119/0x190
Dec 20 00:39:56 home kernel:  [<c0147787>] do_munmap+0x147/0x190
Dec 20 00:39:56 home kernel:  [<c01091c7>] syscall_call+0x7/0xb
Dec 20 00:39:56 home kernel:
Dec 20 00:39:56 home kernel: Code:  Bad EIP value.

Then, I wanted to see if the module was here again and typed "lsmod", 
and it hanged. At this state, I can't load any other module because 
modprobe hangs too. My kernel is compiled with both "module unloading" 
and "forced module unloading."

If needed, may you tell me how I could provide further informations ?

Thanks :-) And great job for 2.6 anyway ;-)
