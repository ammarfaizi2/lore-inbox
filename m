Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbQKIExQ>; Wed, 8 Nov 2000 23:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbQKIExG>; Wed, 8 Nov 2000 23:53:06 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:24822 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S130209AbQKIEww>; Wed, 8 Nov 2000 23:52:52 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Wed, 08 Nov 2000 00:51:33 +1100."
             <14032.973605093@ocs3.ocs-net> 
Date: Thu, 09 Nov 2000 15:52:47 +1100
Message-Id: <20001109045247.BE39A8120@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <14032.973605093@ocs3.ocs-net> you write:
> On Tue, 07 Nov 2000 10:30:39 -0300, 
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> >Note! This _has_ to be in the / filesystem so it works before mounting the
> >rest of the stuff (if ever). This would rule out /var, and leave just
> >/lib/modules/<version>. Makes me quite unhappy...
> 
> Modules are loaded before non-root file systems are mounted, damn!

modules.conf already breaks FHS lib/ badly enough.  Modules loaded
before /var is mounted won't get persistant data.  Too bad; they
have to do something sane when it doesn't exist anyway.

> Looks like persistent data has to be stored in /lib/modules/persist (no
> <version>, see earlier mail).

You need versions: binary data is too prone to change (proven kernel
history).  It's the kernel installer's duty to know which ones can be
safely linked/copied to the new version.

Otherwise every data change requires a new symbol name: and this will
happen all the time.

Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
