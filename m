Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTBUAag>; Thu, 20 Feb 2003 19:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBUAag>; Thu, 20 Feb 2003 19:30:36 -0500
Received: from dp.samba.org ([66.70.73.150]:28856 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266938AbTBUAaf>;
	Thu, 20 Feb 2003 19:30:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-reply-to: Your message of "Thu, 20 Feb 2003 09:38:50 -0800."
             <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com> 
Date: Fri, 21 Feb 2003 11:30:25 +1100
Message-Id: <20030221004041.05C1F2C2D5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com> you write:
> >There has been talk of this, but OTOH, the admin has explicitly gone
> >out of their way to remove this module.  They really don't want anyone
> >new using it.  Presumably at this very moment they are killing off all
> >the processes they can find with such a socket.
> The thing is that once those processes are killed sockets will be 
> destroyed and release the module anyway. i.e. There is no reason to
> sort of artificially force accept() to fail. Everything will be cleaned 
> up once the process is gone.

Yes, but in practical terms it's probably going to fork a child with
that socket.

> >I think it can be argued both ways, honestly.
> Yep. And I'd argue in for of module_get() :)

My only real insistence in this is that such an interface be called
__try_module_get(), because the "__" warn people that it's a "you'd
better know *exactly* what you are doing", even though the "try" is a
bit of a misnomer.

"module_get" sounds like a "simpler" try_module_get()...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
