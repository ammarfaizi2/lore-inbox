Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318163AbSHMPaf>; Tue, 13 Aug 2002 11:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHMPaf>; Tue, 13 Aug 2002 11:30:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318163AbSHMPae>; Tue, 13 Aug 2002 11:30:34 -0400
Date: Tue, 13 Aug 2002 08:36:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131712270.30879-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208130834320.5192-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> the attached patch implements a new syscall, exit_free():
> 
> 	exit_free(error_code, addr, val);
> 
> this syscall is used as a performance optimization in glibc's threading
> library.

This looks like a total glibc braindamage hack.

It may be small, but it's crap, unless you can explain to me why glibc
cannot just cannot just catch the death signal in the master thread and be
done with it (and do all maintenance in the master).

Too ugly to live.

		Linus

