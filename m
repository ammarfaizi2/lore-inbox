Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbSKPRgY>; Sat, 16 Nov 2002 12:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbSKPRgY>; Sat, 16 Nov 2002 12:36:24 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:30393 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267312AbSKPRgX> convert rfc822-to-8bit; Sat, 16 Nov 2002 12:36:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sat, 16 Nov 2002 18:43:36 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
References: <200211161657.51357.m.c.p@wolk-project.de> <200211161810.23039.m.c.p@wolk-project.de> <20021116173224.GG31697@dualathlon.random>
In-Reply-To: <20021116173224.GG31697@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211161841.59889.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 18:32, Andrea Arcangeli wrote:

Hi Andrea,

> you may want to try with this setting that helps with very slow devices:
> 	echo 2 500 0 0 500 3000 3 1 0 > /proc/sys/vm/bdflush
>
> or also with my current default tuned for high performance:
> 	echo 50 500 0 0 500 3000 60 20 > /proc/sys/vm/bdflush
I've tested both without any changes, "pausings" are still there.

> you may have too many dirty buffers around and you end running at disk
> speed at every memory allocation, the first setting will decrease the
> amount of dirty buffers dramatically, if you still have significant
> slowdown with the first setting above, it's most probably only the usual
> elevator issue.
Seems so.

So I have to use 2.4.18 until there is a real proper fix for that.

ciao, Marc
