Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbUJ0WRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbUJ0WRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUJ0WNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:13:42 -0400
Received: from spectre.fbab.net ([212.214.165.139]:14992 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S262932AbUJ0VmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:42:03 -0400
Message-ID: <41801622.5040207@fbab.net>
Date: Wed, 27 Oct 2004 23:41:54 +0200
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu>
In-Reply-To: <20041027130359.GA6203@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing out this patch on an debian box.
There seems to be a problem with enable_irq in the e100 driver that 
makes the network to b0rk.

What information do you need to get something useful out of this?
I saw that others have this problem, so I've got an serial console to 
the box, if you want me to do any tests, tell me how.


Regards,
Magnus


Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: ifconfig/924: BUG in enable_irq at 
kernel/irq/manage.c:112
  [<c01362a0>] enable_irq+0xe4/0x12c (8)
  [<d08a44f6>] e100_up+0x119/0x224 [e100] (44)
  [<d08a5743>] e100_open+0x2c/0x84 [e100] (44)
  [<c0237dda>] dev_open+0x76/0x85 (28)
  [<c02394a8>] dev_change_flags+0x5d/0x138 (24)
  [<c0237cbd>] dev_load+0x31/0x6c (12)
  [<c027915c>] devinet_ioctl+0x5f9/0x6c6 (20)
  [<c027b1b8>] inet_ioctl+0xc7/0xd3 (104)
  [<c022ea5e>] sock_ioctl+0x19f/0x26a (24)
  [<c016c897>] sys_ioctl+0x1e8/0x249 (28)
  [<c0113eea>] do_page_fault+0x0/0x5ee (24)
  [<c0105bb3>] syscall_call+0x7/0xb (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: enable_irq+0x31/0x12c [<c01361ed>] / (0x0 [<00000000>])
.. entry 2: print_traces+0x14/0x47 [<c0130201>] / (0x0 [<00000000>])
