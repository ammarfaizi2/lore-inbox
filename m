Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTK0DPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 22:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTK0DPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 22:15:06 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:5762 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264429AbTK0DPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 22:15:02 -0500
Date: Wed, 26 Nov 2003 22:13:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Vince <fuzzy77@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot in usbcore] 2.6.0-test10-mm1 (culprit:
 modem_run)
In-Reply-To: <3FC54C7E.50904@free.fr>
Message-ID: <Pine.LNX.4.58.0311262213080.1683@montezuma.fsmlabs.com>
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
 <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
 <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
 <3FC54C7E.50904@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, Vince wrote:

> It worked, but I had -- as expected -- to write the oops by hand.
> (user request to Randy: would it be possible to have an option in
> kmsgdump to only write the first oops on floppy ???)
>
> I it have all on paper, but I'm too lazy to write the full stack right
> now (available later on request: I have to go to bed now 8):

Yes please get it all done =) Especially the first line and the bottom
"Code:" line.

> CPU: 0
> EIP: 0060 : [<d0ae9822>]
> EFLAGS: 00010246
> EIP is at releaseintf+0x62/0x80 [usbcore]
> eax:00000000 ebx:ceddc224 ecx:cs6D5DC0 edx:00000000
> esi:ceddc200 edi:00000000 ebp:cd647f0c esp:cd647ef8
> ds: 007b es:007b ss:0068
>
> Process: modem_run (pid: 1121, threadinfo=cd646000, task=ce644040)
> Stack: c016ffe3 ce0bfb24 ce6d5dc0 ...
> [...]
>
> Call trace
> [<c016ffe3>] iput+0x63/0x80
> [<d0ae9c27>] usbdev_release+0xb7/0xc0 [usbcore]
> [<c0157a5c>] __fput+0x10c/0x120
> [<c0156047>] filp_close+0x57/0x80
> [<c0123d17>] put_files_struct+0x67/0xd0
> [<c012491e>] do_exit+0x3a/0xb0
> [<c0124c4a>] do_group_exit+0x3a/0xb0
> [<c02a302e>] sysenter_past_esp+0x43/0x65
