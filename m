Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSIWO3Y>; Mon, 23 Sep 2002 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSIWO3X>; Mon, 23 Sep 2002 10:29:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59978 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261745AbSIWO3X>; Mon, 23 Sep 2002 10:29:23 -0400
Date: Mon, 23 Sep 2002 10:34:17 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Con Kolivas <conman@kolivas.net>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Message-ID: <20020923103417.V21220@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com> <1032791089.3d8f2431231ac@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032791089.3d8f2431231ac@kolivas.net>; from conman@kolivas.net on Tue, Sep 24, 2002 at 12:24:49AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 12:24:49AM +1000, Con Kolivas wrote:
> That is the system I was considering. I just need to run enough benchmarks to
> make this worthwhile though. That means about 5 for each it seems - which may
> take me a while. A basic mean will suffice for a measure of central tendency. I
> also need to quote some measure of variability. Standard deviation?

BTW: Have you tried gcc 3.2 with say -finline-limit=2000 too?
By default gcc 3.2 has for usual C code smaller inlining cutoff, so the IO
difference might as well be because some important, but big function was
inlined by 2.95.x and not by 3.2.x. On the other side there is
__attribute__((always_inline)) which you can use to tell gcc you don't
want any cutoff for a particular function.

	Jakub
