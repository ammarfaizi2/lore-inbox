Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUBXGxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 01:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUBXGxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 01:53:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:10886 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262189AbUBXGxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 01:53:32 -0500
Date: Mon, 23 Feb 2004 22:53:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: rathamahata@php4.ru, linux-kernel@vger.kernel.org, gluk@php4.ru,
       anton@megashop.ru
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040223225337.217447be.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0402240357350.6209@logos.cnet>
References: <200401311940.28078.rathamahata@php4.ru>
	<20040221113044.7deb60b9.akpm@osdl.org>
	<200402222039.58702.gluk@php4.ru>
	<200402232027.26958.rathamahata@php4.ru>
	<20040223142626.48938d7c.akpm@osdl.org>
	<Pine.LNX.4.58L.0402240357350.6209@logos.cnet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  > Also, run
>  >
>  > 	while true
>  > 	do
>  > 		cat /proc/meminfo
>  > 		sleep 10
>  > 	done
>  >
>  > and record the info which that leaves behind when the machine locks up.
>  > This should tell us whether it is an application or kernel memory leak.  If
>  > it is indeed a leak.
> 
>  Hi Andrew,
> 
>  Care to explain me why should the kernel hang if due to an application
>  leak ?

It shouldn't - the oom killer should have done something.  But we'll
address that once we've confirmed that something really is leaking.

>  The hang looks wrong even if the leak is in userspace app, yes?

Probably, yes.
