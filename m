Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319195AbSHGT2y>; Wed, 7 Aug 2002 15:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319266AbSHGT2y>; Wed, 7 Aug 2002 15:28:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60642 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319195AbSHGT2y>;
	Wed, 7 Aug 2002 15:28:54 -0400
Date: Wed, 7 Aug 2002 21:31:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.30-A1
In-Reply-To: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208072128460.26329-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002, Linus Torvalds wrote:

> I would suggest:
>  - move all kernel-related (and thus non-visible to user space) segments 
>    up, and make the cacheline optimizations _there_. 
>  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
>    GDT entry #8) is available to a TLS entry, since if I remember
>    correctly, that one is also magical for old Windows binaries for all
>    the wrong reasons (ie it was some system data area in DOS and in 
>    Windows 3.1)
>  - and for cleanliness bonus points: make the regular user data segments 
>    just another TLS segment that just happens to have default values. If 
>    the user wants to screw with its own segments, let it.

i'll do this. Julliard, any additional suggestions perhaps - is GDT entry
8 the best %fs choice for Wine?

	Ingo

