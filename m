Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291452AbSBHHb3>; Fri, 8 Feb 2002 02:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291453AbSBHHbT>; Fri, 8 Feb 2002 02:31:19 -0500
Received: from [217.7.28.131] ([217.7.28.131]:1297 "EHLO inetgate.hob.de")
	by vger.kernel.org with ESMTP id <S291452AbSBHHbF>;
	Fri, 8 Feb 2002 02:31:05 -0500
Message-ID: <3C637CDD.E0EEBF96@hob.de>
Date: Fri, 08 Feb 2002 08:23:09 +0100
From: Christian Hildner <christian.hildner@hob.de>
Organization: hob electronic
X-Mailer: Mozilla 4.78 [de]C-CCK-MCD DT  (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] kmalloc() size-limitation
In-Reply-To: <3C3D6A89.27EAA4C7@hob.de>
		<15421.61910.163437.45726@napali.hpl.hp.com>
		<3C3ED5E7.8BA479B7@hob.de>
		<15423.5404.65155.924018@napali.hpl.hp.com>
		<3C43D6EC.74B4EC85@hob.de>
		<d31yg1lzgm.fsf@lxplus052.cern.ch>
		<3C5F80F2.54AF98E3@hob.de> <15458.41366.1639.628598@trained-monkey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen schrieb:

> >>>>> "Christian" == Christian Hildner <christian.hildner@hob.de> writes:
>
> Christian> Jes Sorensen schrieb:
> >> Because drivers needs to work on all architectures and relying on
> >> different hahavior from kmalloc() is bad.
>
> Christian> sorry for being unclear. I mean from increasing the kmalloc()
> Christian> size-limit all platforms would benefit.
>
> Thats not really a good idea, and definately not something you want to
> rely on. A lot of architectures are still stuck with 4KB pages and
> trying to allocate 128KB on larger in one chunk is likely to fail after
> the system has been running for a while. On an ia64 with 16KB or 64KB
> pages it's fairly likely it will work, but this is not necessarily a
> good idea to do for other archs. If you need such a large block of
> memory, vmalloc() is the real way to go.
>
> Jes

I think you are right. Memory fragmentation will become a real problem on
small machines.

Christian

