Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbSITLG4>; Fri, 20 Sep 2002 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSITLG4>; Fri, 20 Sep 2002 07:06:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65201 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262242AbSITLGz>;
	Fri, 20 Sep 2002 07:06:55 -0400
Date: Fri, 20 Sep 2002 13:19:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <1032518123.2024.6.camel@ldb>
Message-ID: <Pine.LNX.4.44.0209201317540.3831-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Sep 2002, Luca Barbieri wrote:

> Great, but how about using code similar to the following rather than
> hand-coded asm operations?
> 
> extern struct pthread __pt_current_struct asm("%gs:0");
> #define __pt_current (&__pt_current_struct)
> 
> #define THREAD_GETMEM(descr, member) (__pt_current->member)
> #define THREAD_SETMEM(descr, member, value) ((__pt_current->member) =
> value)
> #define THREAD_MASKMEM(descr, member, mask) ((__pt_current->member) &=
> mask)
> ...

it's a good idea i think. Ulrich has an obsession with writing code in
assembly though :-)

	Ingo


