Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422704AbWGNSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWGNSgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWGNSgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:36:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:65273 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422704AbWGNSgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:36:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZBE7aqevTX2msT7AOuJQJMbzzAjubBQDPWqmgEjlIlc/Zel4Epfn9U2R/Wy3TZZtBtaAXNPqmVkjwxgh0MlvrDif1tqiRnFSZ3DeeyEjNX2B/oVOmV16WcuQdJgt6CyGNIca2iktmVtiuGRP/m9Aw1ElfDEaJkRchYNQe42xNbY=
Message-ID: <6bffcb0e0607141136g43c3ae68jfafcb15333c008b6@mail.gmail.com>
Date: Fri, 14 Jul 2006 20:36:08 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Reuben Farrelly" <reuben-lkml@reub.net>
In-Reply-To: <20060714110051.35902bfa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <200607141336.08989.rjw@sisk.pl>
	 <20060714110051.35902bfa.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 14/07/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 14 Jul 2006 13:36:08 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > Unable to handle kernel NULL pointer dereference at 0000000000000038 RIP:
> >  [<ffffffff8024a07b>] __lock_acquire+0x7b/0xd30
> > PGD 0
> > Oops: 0000 [1] PREEMPT
> > last sysfs file: /devices/pci0000:00/0000:00:0a.0/subsystem_vendor
> > CPU 0
> > Modules linked in: ehci_hcd snd_page_alloc ip6t_REJECT xt_tcpudp i2c_nforce2 i2c_core ipt_REJECT xt_state ohci_hcd iptable_mangle iptable_n
> > at ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables parport_pc lp ip6table_filter parport ip6_tables x_tables ipv6 dm_mod
> > Pid: 110, comm: khubd Not tainted 2.6.18-rc1-mm2 #3
> > RIP: 0010:[<ffffffff8024a07b>]  [<ffffffff8024a07b>] __lock_acquire+0x7b/0xd30
> > RSP: 0018:ffff81005feb1c18  EFLAGS: 00010046
> > RAX: 0000000000000002 RBX: 0000000000000246 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000030
> > RBP: ffff81005feb1c88 R08: 0000000000000002 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8046e23f
> > R13: 0000000000000000 R14: ffff81005fe92040 R15: 0000000000000030
> > FS:  00002b0df5390b00(0000) GS:ffffffff808c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> > CR2: 0000000000000038 CR3: 000000005dc35000 CR4: 00000000000006e0
> > Process khubd (pid: 110, threadinfo ffff81005feb0000, task ffff81005fe92040)
> > Stack:  0000000000000000 ffff81005fe92040 ffff81005febe7a8 ffffffff80470079
> >  0000000200000000 0000000000000000 ffffffff80470038 0000000000000246
> >  ffff81005a701680 0000000000000246 ffffffff8046e23f 0000000000000002
> > Call Trace:
> >  [<ffffffff8024b0bb>] lock_acquire+0x8b/0xc0
> >  [<ffffffff8047193f>] _spin_lock+0x2f/0x40
> >  [<ffffffff8046e23f>] klist_remove+0x1f/0x50
> >  [<ffffffff803b9817>] bus_remove_device+0xa7/0xe0
> >  [<ffffffff803b80f9>] device_del+0x149/0x180
> >  [<ffffffff803d2d95>] usb_disconnect+0x105/0x150
> >  [<ffffffff803d5cc6>] hub_thread+0x616/0xfd0
> >  [<ffffffff80243809>] kthread+0xd9/0x110
> >  [<ffffffff8020a316>] child_rip+0x8/0x12
>
> I seem to have made a programming mistake.
>
>

Thanks! Problem solved.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
