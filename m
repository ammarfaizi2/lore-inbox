Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318770AbSHGRFa>; Wed, 7 Aug 2002 13:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSHGRFa>; Wed, 7 Aug 2002 13:05:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37589 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318770AbSHGRF3>;
	Wed, 7 Aug 2002 13:05:29 -0400
Date: Wed, 7 Aug 2002 19:07:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] [2.5 i386] Swap TLS and TSS entries to improve spatial
 locality
In-Reply-To: <1028739938.11775.30.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208071906580.20926-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Aug 2002, Luca Barbieri wrote:

> GDT entries are usually accessed with this pattern:
>         * Interrupt: read TSS (for ss0:esp0) and kernel CS/DS
>         * Schedule: write TLS, LDT, load FS and GS (either TLS, user DS
>           or LDT entry)
>         * Return: read user CS/DS
> 
> Swapping the TLS and TSS entries causes the GDT entries that are read
> during interrupt and schedule to be in the same cacheline.

yes, this makes perfect sense.

	Ingo

