Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFXVii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFXVih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:38:37 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:17033
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S263600AbTFXVig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:38:36 -0400
From: "jds" <jds@soltis.cc>
To: Lou Langholtz <ldl@aros.net>, jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
Date: Tue, 24 Jun 2003 15:27:13 -0600
Message-Id: <20030624212347.M30881@soltis.cc>
In-Reply-To: <3EF8B15C.8030808@aros.net>
References: <20030624191740.M38428@soltis.cc> <3EF8B15C.8030808@aros.net>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, lou:

   Diseable the # CONFIG_BLK_DEV_NBD is not set, in .config, compile again
kernel and working good.

   Thanks .... :)

   Iam testings my new kernel mm1

   Regards.


---------- Original Message -----------
From: Lou Langholtz <ldl@aros.net>
To: jds <jds@soltis.cc>
Sent: Tue, 24 Jun 2003 14:15:24 -0600
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.

> jds wrote:
> 
> >Hi Andrew:
> >
> >
> >    I have kernel panic when boot with kernel 2.5.73-mm1, in kernel 2.5.73
> >working good.
> >
> >    Anex part the OOps: . . .
> >
> >    [< c020f503>]  kobject_register+0x23/0x60
> >    [<             blk_register_queue+0x80/0xb0
> >                   nbd_init+0x1df/0x220
> >                   do_initcalls+0x2b/0xa0
> >                   init_workqueues+0x12/0x30
> >                   init+0x28/0x150
> >                   init+0x0/0x150
> >                   kernel_thread_helper+0x50/0xc
> >. . .
> >
> I think this is my fault. I introduced a patch to nbd that 
> apparantly doesn't use the block layer quite the way the block layer 
> developers expect. As you found, it works on 2.5.73 but not in 
> 2.5.73-mm1. I'm looking into why exactly this is so I can get a fix 
> ASAP. In the meantime, if you take out the network block driver you 
> shouldn't get this oops anymore.
------- End of Original Message -------

