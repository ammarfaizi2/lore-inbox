Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270786AbUJUSQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270786AbUJUSQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270633AbUJUSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:13:57 -0400
Received: from mail4.utc.com ([192.249.46.193]:49345 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S268987AbUJUSHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:07:42 -0400
Message-ID: <4177FADC.6030905@cybsft.com>
Date: Thu, 21 Oct 2004 13:07:24 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
In-Reply-To: <20041021132717.GA29153@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010203090607040104010404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203090607040104010404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -U9 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

Finally a patch that I can get booted on my older SMP system at home 
again. More correctly it is U9.2. I have been having problems with these 
hanging after U5. Haven't had a ton of time to try to track down the 
problems and didn't want to report problems without having done enough 
troubleshooting. Anyway, I got this while booting U9.2.

kr


--------------010203090607040104010404
Content-Type: text/plain;
 name="tulipbug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulipbug.txt"

Oct 21 12:33:22 porky kernel: BUG: atomic counter underflow at:
Oct 21 12:33:22 porky kernel:  [<c0254dd8>] qdisc_destroy+0x98/0xa0 (12)
Oct 21 12:33:22 porky kernel:  [<c0254fed>] dev_shutdown+0x3d/0xa0 (16)
Oct 21 12:33:22 porky kernel:  [<c024773b>] unregister_netdevice+0x13b/0x280 (28)
Oct 21 12:33:22 porky netfs: Mounting other filesystems:  succeeded
Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (12)
Oct 21 12:33:22 porky kernel:  [<e09a6160>] tulip_remove_one+0x0/0xa0 [tulip] (4)
Oct 21 12:33:22 porky kernel:  [<c02058de>] unregister_netdev+0x1e/0x30 (24)
Oct 21 12:33:22 porky kernel:  [<e09a618f>] tulip_remove_one+0x2f/0xa0 [tulip] (16)
Oct 21 12:33:22 porky kernel:  [<c01f2907>] device_release_driver+0x67/0x70 (8)
Oct 21 12:33:22 porky kernel:  [<c0112fb0>] mcount+0x14/0x18 (8)
Oct 21 12:33:22 porky kernel:  [<c01c4e26>] pci_device_remove+0x76/0x80 (20)
Oct 21 12:33:22 porky kernel:  [<c01f573b>] device_detach_shutdown+0xb/0x40 (12)
Oct 21 12:33:22 porky kernel:  [<c01f2907>] device_release_driver+0x67/0x70 (12)
Oct 21 12:33:22 porky kernel:  [<c01f293b>] driver_detach+0x2b/0x40 (24)
Oct 21 12:33:22 porky kernel:  [<c01f2daf>] bus_remove_driver+0x3f/0x70 (20)
Oct 21 12:33:22 porky kernel:  [<c01f32b9>] driver_unregister+0x19/0x30 (20)
Oct 21 12:33:22 porky kernel:  [<c01c50cc>] pci_unregister_driver+0x1c/0x30 (16)
Oct 21 12:33:22 porky kernel:  [<e09a7767>] tulip_cleanup+0x17/0x1b [tulip] (16)
Oct 21 12:33:22 porky kernel:  [<c0139801>] sys_delete_module+0x121/0x150 (12)
Oct 21 12:33:22 porky kernel:  [<c01531a1>] sys_munmap+0x51/0x60 (64)
Oct 21 12:33:22 porky kernel:  [<c0116a20>] do_page_fault+0x0/0x660 (16)
Oct 21 12:33:22 porky kernel:  [<c0106719>] sysenter_past_esp+0x52/0x71 (16)
Oct 21 12:33:22 porky kernel: preempt count: 00000001
Oct 21 12:33:22 porky kernel: . 1-level deep critical section nesting:
Oct 21 12:33:22 porky kernel: .. entry 1: print_traces+0x1d/0x60 / (dump_stack+0x23/0x30)
Oct 21 12:33:22 porky kernel: 
Oct 21 12:33:22 porky kernel: tulip 0000:04:0a.0: Device was removed without properly calling pci_disable_device(). This may need fixing.

--------------010203090607040104010404--
