Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVLSVRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVLSVRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVLSVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:17:46 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6803 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964988AbVLSVRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:17:45 -0500
Message-ID: <43A72350.40909@colorfullife.com>
Date: Mon, 19 Dec 2005 22:17:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, clameter@sgi.com, anton@samba.org,
       sonnyrao@us.ibm.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
References: <20051219051659.GA6299@kevlar.burdell.org> <1134974518.10035.5.camel@gaston> <20051219070850.GA11956@kevlar.burdell.org>
In-Reply-To: <20051219070850.GA11956@kevlar.burdell.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

>Ok, tried it: same crash on -rc6
>
>2:mon> t
>[c000000d9f33b820] c000000000097cd0 .kfree+0x29c/0x2cc
>[c000000d9f33b8d0] c00000000009c3a8 .cpuup_callback+0x4f8/0x5fc
>[c000000d9f33b9c0] c00000000048ff4c .notifier_call_chain+0x68/0x9c
>[c000000d9f33ba50] c000000000078da8 .cpu_down+0x1fc/0x368
>[c000000d9f33bb40] c0000000002ae514 .store_online+0x88/0xe8
>[c000000d9f33bbd0] c0000000002a8dd0 .sysdev_store+0x4c/0x68
>[c000000d9f33bc50] c000000000111e70 .sysfs_write_file+0x100/0x1a0
>[c000000d9f33bcf0] c0000000000c0360 .vfs_write+0x100/0x200
>[c000000d9f33bd90] c0000000000c0570 .sys_write+0x54/0x9c
>[c000000d9f33be30] c000000000008600 syscall_exit+0x0/0x18
>  
>
Very odd call chain.
Could you enable slab debugging?

--
    Manfred
