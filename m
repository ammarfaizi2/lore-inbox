Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTGUMzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTGUMzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:55:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6327 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269987AbTGUMzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:55:36 -0400
Date: Mon, 21 Jul 2003 09:45:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre5 deadlock
In-Reply-To: <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local>
 <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Jul 2003, Jim Gifford wrote:

> ----- Original Message -----
> From: "Andrea Arcangeli" <andrea@suse.de>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>; "lkml"
> <linux-kernel@vger.kernel.org>
> Sent: Saturday, July 19, 2003 10:21 AM
> Subject: Re: 2.4.22-pre5 deadlock
>
>
> > On Mon, Jul 14, 2003 at 10:03:03AM -0700, Jim Gifford wrote:
> > > As requested.
> >
> > please try to reproduce w/o devfs and/or w/o a kernel module that is
> > loadable called ipt_psd (netfilter stuff likely, but not part of
> > mainline pre6/pre7). probably it'll go away either ways and it seems
> > triggered by the process called couriertcpd. Not sure exactly what's
> > going on though, since looking into devfs/devfsd doesn't sound
> > interesting anymore and I don't see the netfilter code out of mainline.
> >
> > (probably this email will get some delay, so apologies if it is obsolete
> > by the time it reaches the network)
> >
> > Andrea
> >
> I have removed all non-standard iptables modules and the dazuko module. It
> locked up under pre6 without these modules, but pre7 hasn't caused a problem
> yet, it's at 28 hours so far, the record is three days. I have noticed
> increased memory usage, which is the starting sign of problems.

Jim,

The increased memory usage seems normal. Its the kernel cahcing more and
more buffers: they will be freed when the system needs memory.

Lets wait and see what happens without the iptables and dazuko modules.
