Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUF1PXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUF1PXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbUF1PXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:23:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:35846 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265029AbUF1PVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:21:14 -0400
Message-ID: <40E03C2D.5000809@techsource.com>
Date: Mon, 28 Jun 2004 11:41:33 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org>
In-Reply-To: <40E03376.20705@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

> 
> It definitely should _not_ starve. That is the unixy way of doing
> things. Everything must go forward. Around 5% cpu for nice 19 sounds
> just right. If you want scheduling only when there's spare cpu cycles
> you need a sched batch(idle) implementation.
> 
>

Well, since I can't rewrite the app, I can't make it sched batch.  Nice 
values are an easy thing to get at for anything that's running.

Besides, comparing nice 0 to nice 19, I'd expect something more like a 
100:1 ratio or worse.  (That is, I don't expect nice to be linear.)

Maybe this is just me, but when I set a process to the worst possible 
priority (nice 19), I expect it only to run when nothing else needs the CPU.

