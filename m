Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSEUN6f>; Tue, 21 May 2002 09:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314613AbSEUN6e>; Tue, 21 May 2002 09:58:34 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:64268 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314612AbSEUN6d>; Tue, 21 May 2002 09:58:33 -0400
Date: Tue, 21 May 2002 15:58:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205211544320.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 May 2002, Linus Torvalds wrote:

> And yet more TLB shootdown stuff.

I'm a bit puzzled, how you want to do proper rss accounting, you put now a
"tlb->freed++;" into zap_pte_range(). mmu_gather_t is supposed to be an
opaque type and this access violates this.

bye, Roman

