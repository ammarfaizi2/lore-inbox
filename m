Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSJ1KkS>; Mon, 28 Oct 2002 05:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJ1KkS>; Mon, 28 Oct 2002 05:40:18 -0500
Received: from smtpout.mac.com ([204.179.120.88]:31426 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263256AbSJ1KkR>;
	Mon, 28 Oct 2002 05:40:17 -0500
Message-ID: <3DBD1645.518EFF07@mac.com>
Date: Mon, 28 Oct 2002 11:49:41 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <3DBC1A6B.7020108@colorfullife.com> <3DBC6314.6B8AC5EA@mac.com> <3DBCDF4A.3080709@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul schrieb:
> 
> Peter Waechtler wrote:
> 
> >I plan to separate the interfaces and just share the message stuff.
> >But time was getting short. :)
> >
> 
> Ok, you plan to rewrite the patch entirely, and what you have posted is
> a placeholder.
> 
> How would the result look like?
> I'm thinking about
> - real syscalls
> - pipefs like filesystem stub, kern-only mounted, not visible for normal
> fs operations.
> - not using the sysv array
> 
> Could you check the sus standard if that is permitted? A child would
> inherit the mqueue on fork().
> 

Yes, I will check that - but I'm afraid of submitting too late.. :(

> For the locking stuff, the patch should probably depend on the sysv rcu
> patch, it cleans up locking a bit.
> 

BTW, please have a look at ipc/util.c - the spinlock is held once
ipc_addid() is called and will deadlock when the array has to grow...
