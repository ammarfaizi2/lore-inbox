Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTGFNfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTGFNfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:35:07 -0400
Received: from ool-4352eb9e.dyn.optonline.net ([67.82.235.158]:1920 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id S262316AbTGFNfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:35:01 -0400
Date: Sun, 6 Jul 2003 09:49:26 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm2 [kernel BUG at include/linux/list.h:148!]
Message-ID: <20030706134926.GA472@nikolas.hn.org>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20030705132528.542ac65e.akpm@osdl.org> <1057455650.3119.3.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1057455650.3119.3.camel@debian>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 03:40:51AM +0200, Ram?n Rey Vicente???? wrote:
> Hi.
> 
> Recently compiled and booted succesfully, I obtain this message
> 
> kernel BUG at include/linux/list.h:148!

The same BUG here after 2.5 hours of uptime.
Without preempt (but with nvidia kernel module).

===============================================================================
Jul  6 03:19:15 nikolas kernel: ------------[ cut here ]------------
Jul  6 03:19:15 nikolas kernel: kernel BUG at include/linux/list.h:148!
Jul  6 03:19:15 nikolas kernel: invalid operand: 0000 [#1]
Jul  6 03:19:15 nikolas kernel: CPU:    0
Jul  6 03:19:15 nikolas kernel: EIP:    0060:[remove_wait_queue+75/96]    Tainted: P   VLI
Jul  6 03:19:15 nikolas kernel: EFLAGS: 00010017
Jul  6 03:19:15 nikolas kernel: eax: d84ede2c   ebx: d931be98   ecx: d84ede2c   edx: d931bea4
Jul  6 03:19:15 nikolas kernel: esi: 00000292   edi: d931a000   ebp: d836d240   esp: d931be58
Jul  6 03:19:15 nikolas kernel: ds: 007b   es: 007b   ss: 0068
Jul  6 03:19:15 nikolas kernel: Process syslogd (pid: 794, threadinfo=d931a000 task=db12d900)
Jul  6 03:19:15 nikolas kernel: Stack: d931be98 d84ede2c c018925c c030aa00 00000000 40127860 d84ede28 dffce840 
Jul  6 03:19:15 nikolas kernel:        00000000 db12d900 c0117440 00000000 00000000 d931be98 00000001 d9a8f5e0 
Jul  6 03:19:15 nikolas kernel:        00000000 db12d900 c0117440 d84ede2c d84ede2c d94b9005 000056ed 00000001 
Jul  6 03:19:15 nikolas kernel: Call Trace: [devfs_d_revalidate_wait+300/304]  [default_wake_function+0/48]  [default_wake_function+0/48]  [do_lookup+104/176]  [link_path_walk+1036/1952]  [open_namei+131/992]  [fcntl_setlk+257/672]  [filp_open+62/112]  [sys_open+91/144]  [syscall_call+7/11] 
Jul  6 03:19:15 nikolas kernel: Code: 20 89 48 04 89 01 c7 42 04 00 02 20 00 c7 43 0c 00 01 10 00 56 9d 8b 74 24 04 8b 1c 24 83 c4 08 c3 0f 0b 95 00 04 fd 26 c0 eb d6 <0f> 0b 94 00 04 fd 26 c0 eb c4 8d 74 26 00 8d bc 27 00 00 00 00 
===============================================================================

Hope it helps,
	Nick.
-- 
With best wishes,
	Nick Orlov.

