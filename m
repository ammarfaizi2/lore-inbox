Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWCIGxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWCIGxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWCIGxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:17 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:28326 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751692AbWCIGxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mE52pXg2haJjFwT5obGwTN6MdMtExAsaEnojOLW/oNPTRrhj32y+7DAFbjsYlSBUse/jDlWs9aqWAJV1vensgWG7mOzfcqNVhoPfIYrIrRjTgFwAEvw67PdwtkhMlgSKg9UHZitTmu7P/7VkSY5Tt746surb2iXTXSUdyp6soms=
Message-ID: <a44ae5cd0603082253sfb4a1e1q687c56a6f6a386fb@mail.gmail.com>
Date: Wed, 8 Mar 2006 22:53:10 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.16-rc5-mm3 -- BUG: sleeping function called from invalid context at include/linux/rwsem.h:43 in_atomic():0, irqs_disabled():1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies.  This bug caused my video to get messed up.  I was able to
run Gnome, but the apps weren't rendering correctly, so I couldn't be
sure my subject line was correct.
I would have edited out some of the context info, but that was tough
as well.  Here's the BUG message by itself.  Perhaps all the dmesg
output in the previous message will be helpful.
As you can see in the dmesg output, I hit this by suspending and
resuming.  I am running Fedora Core 5 Test 3 + all yum updates.
Andrew, the full dmesg output is in the LKML message with the subject
line set to "v".  Let me know if you would like me to send it directly
to you.

BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 <c1003f81> show_trace+0xd/0xf   <c100401b> dump_stack+0x17/0x19
 <c1015f77> __might_sleep+0x86/0x90   <c1024738>
blocking_notifier_call_chain+0x1b/0x4d
 <c1183bb2> cpufreq_resume+0xf5/0x11d   <c112b27c> __sysdev_resume+0x23/0x57
 <c112b3c9> sysdev_resume+0x19/0x4b   <c112f736> device_power_up+0x8/0xf
 <c1033339> swsusp_suspend+0x6e/0x8b   <c1033918> pm_suspend_disk+0x51/0xf3
 <c10328c7> enter_state+0x53/0x1c1   <c1032abe> state_store+0x89/0x97
 <c108af00> subsys_attr_store+0x20/0x25   <c108b020> sysfs_write_file+0xb5/0xdc
 <c1056578> vfs_write+0xab/0x154   <c1056aa3> sys_write+0x3b/0x60
 <c1002b43> syscall_call+0x7/0xb
PM: Image restored success
