Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKNTTS>; Thu, 14 Nov 2002 14:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSKNTTS>; Thu, 14 Nov 2002 14:19:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42156 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261594AbSKNTTR>; Thu, 14 Nov 2002 14:19:17 -0500
Subject: Re: [patch] remove hugetlb syscalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David.Mosberger@acm.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15827.61722.800066.756875@panda.mostang.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
	<08a601c28bbb$2f6182a0$760010ac@edumazet>
	<20021114141310.A25747@infradead.org> <ugel9oavk4.fsf@panda.mostang.com>
	<1037298675.16000.47.camel@irongate.swansea.linux.org.uk> 
	<15827.61722.800066.756875@panda.mostang.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 19:52:12 +0000
Message-Id: <1037303532.15996.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 18:53, David Mosberger-Tang wrote:
> But that's excactly the point.  The hugepage interface returns a
> different kind of virtual memory.  There are tons of programs out
> there using mmap().  If such a program gets fed a path to the
> hugepagefs, it might end up with huge pages without knowing anything
> about huge pages.  For the most part, that might work fine, but it
> could lead to subtle failures.

Your argument makes sense. You are arguing

I created it with weirdass syscall, magically all my libraries and other
apps will know this so not use mremap etc on that space.

Thats complete donkey poo

