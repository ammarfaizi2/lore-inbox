Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDNFuE>; Sat, 14 Apr 2001 01:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDNFtz>; Sat, 14 Apr 2001 01:49:55 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132745AbRDNFtt>;
	Sat, 14 Apr 2001 01:49:49 -0400
Date: Fri, 13 Apr 2001 21:40:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <Pine.LNX.4.21.0104140049360.12164-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.31.0104132138310.24573-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Apr 2001, Rik van Riel wrote:
>
> Also, have you managed to find a real difference with this?

It actually makes a noticeable difference on lmbench, so I think adam is
100% right.

> If it turns out to be beneficial to run the child first (you
> can measure this), why not leave everything the same as it is
> now but have do_fork() "switch threads" internally ?

Probably doesn't much matter. We've invalidated the TLB anyway due to the
page table copy, so the cost of switching the MM is not all that
noticeable.

		Linus

