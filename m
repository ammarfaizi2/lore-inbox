Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWAXRIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWAXRIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWAXRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:08:39 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52964 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030447AbWAXRIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:08:38 -0500
Message-Id: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
cc: "Diego Calleja" <diegocg@gmail.com>, "Ram Gupta" <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream... 
In-Reply-To: Message from "linux-os \(Dick Johnson\)" <linux-os@analogic.com> 
   of "Mon, 23 Jan 2006 11:11:29 CDT." <Pine.LNX.4.61.0601231058200.11299@chaos.analogic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 23 Jan 2006 23:08:53 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 24 Jan 2006 14:08:07 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:
> On Mon, 23 Jan 2006, Diego Calleja wrote:

[...]

> > However, I doubt the approach is really useful. If you need that much
> > swap space, you're going well beyond the capabilities of the machine.
> > In fact, I bet that most of the cases of machines needing too much
> > memory will be because of bugs in the programs and OOM'ing would be
> > a better solution.

Good rule of thumb: If you run into swap, add RAM. Swap is /extremely/ slow
memory, however fast you make it go. RAM is not expensive anymore...

> You have roughly 2 GB of dynamic address-space avaliable to each
> task (stuff that's not the kernel and not the runtime libraries).

Right. But your average task is far from that size, and most of it resides
in shared libraries and (perhaps shared) executables, and is perhaps even
COW shared with other tasks.

> You can easily have 500 tasks,

Even thousands.

>                                even RedHat out-of-the-box creates
> about 60 tasks. That's 1,000 GB of potential swap-space required
> to support this.

But you really never do. That is the point.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

