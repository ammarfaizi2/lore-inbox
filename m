Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSKRPTY>; Mon, 18 Nov 2002 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSKRPTY>; Mon, 18 Nov 2002 10:19:24 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19876 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261418AbSKRPTX>;
	Mon, 18 Nov 2002 10:19:23 -0500
Date: Mon, 18 Nov 2002 17:42:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luca Barbieri <ldb@ldb.ods.org>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037625619.7547.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211181742350.12751-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Nov 2002, Alan Cox wrote:

> What is the behaviour of someone setting VM_DONTCOPY on memory that was
> copy on write between a large number of processes (say an executable
> image) ?  Don't copy - but don't copy from what, from the original
> mapping or from the COW mapping of the original mapping ?

it would result in a VM 'hole' - completely unmapped virtual memory with
no vma backing it.

	Ingo

