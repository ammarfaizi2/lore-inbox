Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFXUBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTFXUBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:01:20 -0400
Received: from dm6-35.slc.aros.net ([66.219.221.35]:7301 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262299AbTFXUBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:01:17 -0400
Message-ID: <3EF8B15C.8030808@aros.net>
Date: Tue, 24 Jun 2003 14:15:24 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
References: <20030624191740.M38428@soltis.cc>
In-Reply-To: <20030624191740.M38428@soltis.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jds wrote:

>Hi Andrew:
>
>
>    I have kernel panic when boot with kernel 2.5.73-mm1, in kernel 2.5.73
>working good.
>
>    Anex part the OOps: . . .
>
>    [< c020f503>]  kobject_register+0x23/0x60
>    [<             blk_register_queue+0x80/0xb0
>                   nbd_init+0x1df/0x220
>                   do_initcalls+0x2b/0xa0
>                   init_workqueues+0x12/0x30
>                   init+0x28/0x150
>                   init+0x0/0x150
>                   kernel_thread_helper+0x50/0xc
>. . .
>
I think this is my fault. I introduced a patch to nbd that apparantly 
doesn't use the block layer quite the way the block layer developers 
expect. As you found, it works on 2.5.73 but not in 2.5.73-mm1. I'm 
looking into why exactly this is so I can get a fix ASAP. In the 
meantime, if you take out the network block driver you shouldn't get 
this oops anymore.

