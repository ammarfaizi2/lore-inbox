Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUBJTRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUBJTRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:17:41 -0500
Received: from [217.73.129.129] ([217.73.129.129]:9928 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S266030AbUBJTRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:17:37 -0500
Date: Tue, 10 Feb 2004 21:17:22 +0200
Message-Id: <200402101917.i1AJHMuc131759@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.6.3-rc1-mm1 - Badness in kobject_get
To: linux-kernel@vger.kernel.org, bcollins@debian.org
References: <1ngdf-3Qx-1@gated-at.bofh.it> <m3ptcotskr.fsf@terminal124.gozu.lan> <20040209174833.GA9639@kroah.com> <20040209175125.GM1042@phunnypharm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Ben Collins <bcollins@debian.org> wrote:
>> > Freeing unused kernel memory: 152k freed
>> > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c6405]
>> > Badness in kobject_get at lib/kobject.c:431
>> > Call Trace:
>> >  [<c020d15c>] kobject_get+0x4c/0x50
>> >  [<c025ca28>] get_device+0x18/0x30
>> >  [<c025d6a3>] bus_for_each_dev+0x63/0xc0
>> >  [<c02a9fdd>] nodemgr_node_probe+0x4d/0x130
>> >  [<c02a9ea0>] nodemgr_probe_ne_cb+0x0/0x90
>> >  [<c02aa439>] nodemgr_host_thread+0x179/0x1a0
>> >  [<c02aa2c0>] nodemgr_host_thread+0x0/0x1a0
>> >  [<c0109289>] kernel_thread_helper+0x5/0xc
>> Known issue, please read the archives.
>> Also, no one seems to know what the problem is :(
BC> Nor why it seems to only affect ieee1394, when nothing changed. Also it
BC> seems to only affect -mm.

Nope. It happens with 2.6.3-rc2 here. (note no -mm part)
2.6.2 was fine. I will probably do more experiments to find out which patch
made this to happen.

Bye,
    Oleg
