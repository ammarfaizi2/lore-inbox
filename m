Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbQLDR2z>; Mon, 4 Dec 2000 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbQLDR2q>; Mon, 4 Dec 2000 12:28:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:45551 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130144AbQLDR2e>; Mon, 4 Dec 2000 12:28:34 -0500
Date: Mon, 4 Dec 2000 14:57:34 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: hugang <linuxbest@sina.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Path: for oom_kill.c
In-Reply-To: <20001204162712Z129770-439+868@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0012041456100.29258-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2000, hugang wrote:

> Hello all:
> 	
> old    ---->     points = p->mm->total_vm;
>        
> change to --->   points = p->pid;

Ummm, what exactly do you want to achieve with this?

> before change it ,kernel will kill some pid, to change it kernel
> will kill hello(bash).

Before the change, the kernel will try to kill a BIG process
(the obvious suspect for a memory leak). After the change,
the kernel will kill an almost random process ...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
