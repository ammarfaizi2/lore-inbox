Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265927AbTL3XXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbTL3XU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:20:57 -0500
Received: from mail.webmaster.com ([216.152.64.131]:10218 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265895AbTL3XUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:20:30 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <bluefoxicy@linux.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Slab allocator . . . cache?  WTF is it?
Date: Tue, 30 Dec 2003 15:20:24 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMELIJBAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20031230221859.15F503956@sitemail.everyone.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mem:    775616k total,   747740k used,    27876k free,    96584k buffers
> Swap:   250480k total,    71340k used,   179140k free,   298852k cached
>
>
> This is somewhat distressing.  Last time this happened, I started
> opening every
> program I had (including every OpenOffice.org product and every
> browser I had
> installed), and the "cached" value dropped quickly.

	So, as you've seen, when the kernel needs memory, it can easily throw its
cached data away and gain as much free memory as it needs.

> I'm wondering, what IS cache?  It seems to increase even when
> swap is not used,
> and sometimes when there's no swap partition enabled.  It also
> seems to cause
> me to run into swap when I have ample ram available,

	All true, all good. No matter how much RAM you have available, odds are you
are moving more dat to and from disk then you have RAM. So it sometimes
makes sense to swap stuff to make room for more cache.

> assuming
> that cache is just
> some sort of cache that is copied from and mirrors another
> portion of ram for
> some sort of speed increase.

	More typically, it contains copies of data that was written to or read from
disk in case it is requested (again).

> It's wasteful to me,

	Huh? Why do you say that?

> and I want to
> more understand
> its implimentation and its purpose, and in all honesty limit its
> impact if possible.
> I got this RAM upgrade because I was using about 676M of RAM
> total, including swap,
> at peak; and now I find myself using 820M RAM at peak and about
> 750-800 continually.

	If you don't want the computer to use the RAM, take the RAM out of the
computer. The computer will use all of the RAM you give it. Why shouldn't
it?

	DS


