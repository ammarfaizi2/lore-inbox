Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRBXRr4>; Sat, 24 Feb 2001 12:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRBXRrr>; Sat, 24 Feb 2001 12:47:47 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48900 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129311AbRBXRrn>; Sat, 24 Feb 2001 12:47:43 -0500
Date: Sat, 24 Feb 2001 14:01:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Mike Galbraith <mikeg@wen-online.de>, lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <3A9719FE.D84B70FB@sh0n.net>
Message-ID: <Pine.LNX.4.21.0102241357220.3684-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Feb 2001, Shawn Starr wrote:

> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> 
> didnt, work, still causing this..

Ok, could you please add a line with "BUG();" after the
printk("__alloc_pages: %d-order allocation failed", ..) in mm/page_alloc.c
function __alloc_pages() ?

This will make you get an oops when an allocation fails and if you decode
it (with ksymoops) we can have a pretty useful backtrace to have more clue
of what's failing.

TIA


