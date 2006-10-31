Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWJaAI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWJaAI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWJaAI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:08:56 -0500
Received: from rtr.ca ([64.26.128.89]:56837 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030431AbWJaAI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:08:56 -0500
Message-ID: <45469414.4090108@rtr.ca>
Date: Mon, 30 Oct 2006 19:08:52 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc3-git7: Oops on shutdown: do_remount_sb (reiserfs)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system is a Core2duo with SATA drives, with a SLES10 install,
and a linux-2.6.19-rc3-git7 kernel.  All I did was a fresh boot to
the gdm prompt, and then selected "reboot" from the menu.

Just as it was closing up shop, an Oops appeared on the screen.
I took a photo of it, and transcribed this portion (below).
The photograph is available on request.

devpts unmounted
sysfs unmounted
BUG: unable to handle kernel paging request at virtual address 3a4e5355
 printing eip:
c0177ebc
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: cpufreq_ondemand cpufreq_userspace cpufreq_powersave speedstep_centrino freq_table button battery ac dm_mod ahci edd fan thermal processor
CPU:    0
EIP:    0060:[<c0177ebc>]       Not tainted VLI
EFLAGS: 00010213   (2.6.19-rc3-git7-ml #7)
EIP is at shrink_dcache_sb+0x3c/0x100
...
Process umount (pid ... )
...
Call Trace:
[<c0167d69>] do_remount_sb+0x29/0x160
[<c017d22e>] sys_umount+0x20e/0x220
[<c017d259>] sys_oldumount+0x19/0x20
[<c0102f4d>] sysenter_past_esp+0x56/0x8d
[<b7f4e410>] 0xb7f4e410
Code: e8 ca 6b 1e 00 a1 ...
EIP: [<c0177ebc>] shrink_dcache_sb+0x3c/0x100 SS:ESP 0068:f68e3efc
