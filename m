Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSHRIao>; Sun, 18 Aug 2002 04:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSHRIao>; Sun, 18 Aug 2002 04:30:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57054 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316182AbSHRIan>;
	Sun, 18 Aug 2002 04:30:43 -0400
Date: Sun, 18 Aug 2002 10:35:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Gabriel Paubert <paubert@iram.es>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch 
In-Reply-To: <200208172234.g7HMY2o05554@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208181034220.2143-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, James Bottomley wrote:

> I fixed this as part of my cleanups, but it doesn't actually make a
> difference to the voyagers.  What kills them is either gdt not 8 bytes
> aligned in setup.S or %cs above about 0x30 when going from real to
> protected mode (once in protected mode, it will happily accept arbitrary
> descriptor values).

the later we cannot fix sensibly, it introduces a dependency on our main
GDT. And it's good to have a small GDT in the boot sector anyway - so your
patch definitely looks good to me.

	Ingo

