Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUJTTGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUJTTGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269137AbUJTTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:06:35 -0400
Received: from brown.brainfood.com ([146.82.138.61]:50340 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268989AbUJTTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:02:44 -0400
Date: Wed, 20 Oct 2004 14:02:30 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Alexander Batyrshin <abatyrshin@ru.mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
In-Reply-To: <4176A50C.9050303@ru.mvista.com>
Message-ID: <Pine.LNX.4.58.0410201401430.1219@gradall.private.brainfood.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
 <20041020094508.GA29080@elte.hu> <4176A50C.9050303@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Alexander Batyrshin wrote:

>
>
> Ingo Molnar wrote:
> > i have released the -U8 Real-Time Preemption patch:
> >
> >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> >
>
> 2.
> if execute
> ``for i in `seq 1 9999`; do nohup bash >/dev/null 2>&1 & done'',
> then you'll get something like:
> [...skip...]
> Warning: dev (pts0) tty->count(16) != #fd's(8) in tty_open
> Warning: dev (pts0) tty->count(16) != #fd's(11) in tty_open
> Warning: dev (pts0) tty->count(17) != #fd's(13) in tty_open
> Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(19) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(19) != #fd's(16) in release_dev
> Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(19) != #fd's(17) in tty_open
> Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
> Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
> Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
> Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
> Warning: dev (pts0) tty->count(17) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(16) != #fd's(19) in release_dev
> Warning: dev (pts0) tty->count(15) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(13) != #fd's(18) in tty_open
> Warning: dev (pts0) tty->count(14) != #fd's(19) in release_dev
> Warning: dev (pts0) tty->count(13) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(13) != #fd's(17) in release_dev
> Warning: dev (pts0) tty->count(12) != #fd's(18) in tty_open
> Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
> Warning: dev (pts0) tty->count(28) != #fd's(16) in tty_open
> Warning: dev (pts0) tty->count(528) != #fd's(13) in tty_open
> Warning: dev (pts0) tty->count(528) != #fd's(13) in release_dev
> Warning: dev (pts0) tty->count(527) != #fd's(12) in tty_open
> Warning: dev (pts0) tty->count(528) != #fd's(12) in release_dev
> Warning: dev (pts0) tty->count(538) != #fd's(28) in release_dev
> Warning: dev (pts0) tty->count(537) != #fd's(528) in tty_open
> Warning: dev (pts0) tty->count(537) != #fd's(527) in release_dev
> Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
> Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
> Warning: dev (pts0) tty->count(536) != #fd's(527) in release_dev
> Warning: dev (pts0) tty->count(535) != #fd's(527) in tty_open
> Warning: dev (pts0) tty->count(535) != #fd's(530) in tty_open
> [...skip...]
> Warning: dev (pts0) tty->count(11) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(10) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(9) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(8) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(7) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(6) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(5) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(4) != #fd's(71) in release_dev
> Warning: dev (pts0) tty->count(3) != #fd's(71) in release_dev
> eggcups: page allocation failure. order:1, mode:0x20
>   [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
>   [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
>   [<c014719c>] kmem_getpages+0x25/0xe0 (8)
> [...skip...]

I got something like this too, just now.  Not doing anything special(tty7
holds xdm).

Warning: dev (pts7) tty->count(4) != #fd's(3) in tty_open
Warning: dev (pts7) tty->count(4) != #fd's(3) in release_dev
