Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSKMNVm>; Wed, 13 Nov 2002 08:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKMNVU>; Wed, 13 Nov 2002 08:21:20 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:41494
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261337AbSKMNVA>; Wed, 13 Nov 2002 08:21:00 -0500
Date: Wed, 13 Nov 2002 08:22:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] smp_init 'CPUS done' looks strange 
In-Reply-To: <20021113093843.52D432C0B0@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211130820410.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0211122246540.24523-100000@montezuma.mastecende.com> 
> you write:
> > Also, it would make sense in the future if smp_cpus_done actually gets a 
> > value denoting how many cpus are online.
> 
> No.  Drop the prink by all means, but smp_cpus_done() can call
> num_online_cpus() itself.  It can't know how many cpus the user
> specified, however.

Doesn't that just encourage more (i = 0; i < NR_CPUS; i++) usage? If you 
make max_cpus available to everyone, at least they'll have the correct cpu 
count to check against. max_cpus is needed by more than bootup.

	Zwane
-- 
function.linuxpower.ca

