Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTDNUwv (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTDNUwv (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:52:51 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:45329 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S263715AbTDNUwt (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:52:49 -0400
Message-ID: <3E9B1F33.3060701@ixiacom.com>
Date: Mon, 14 Apr 2003 13:50:59 -0700
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, provos@citi.umich.edu
Subject: re: epoll support in libevent-0.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels Provos <provos () citi ! umich ! edu> wrote:

> I just released a new version of libevent that supports Linux new
> epoll mechanism; see
> 
>   http://www.monkey.org/~provos/libevent/
> 
> The page contains some performance comparisons for different event
> notification mechanisms.

Very cool.  This will probably be quite useful for many users.

BTW, Niels should perhaps mention that only the new,
level-triggered version of sys_epoll is supported.

> The library supports platform independent high performance network
> applications.  It chooses the fastest notification mechansims
> supported by the operating system.

That may not be *quite* true.  Davide and I feel the edge-triggered
version of sys_epoll can be slightly faster than the level-triggered version.
Niels disagrees, but presumably a benchmark could be arranged to
settle the question.  Of course, after Davide and I win the
argument :-), Niels will say "but the level-triggered version is easier to use",
and he'll be mostly right.

I'm stuck in /dev/epoll-land for a while, but one of these days,
maybe I'll do that benchmark.

- Dan


