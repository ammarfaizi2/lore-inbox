Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSHPCCT>; Thu, 15 Aug 2002 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHPCCT>; Thu, 15 Aug 2002 22:02:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18693 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317911AbSHPCCT>; Thu, 15 Aug 2002 22:02:19 -0400
Date: Thu, 15 Aug 2002 19:08:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <20020815220054.J29874@redhat.com>
Message-ID: <Pine.LNX.4.44.0208151905500.1271-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Benjamin LaHaise wrote:
> 
> A 4G/4G split flushes the TLB on every syscall.

This is just not going to happen. It will have to continue being a 3/1G 
split, and we'll just either find a way to move stuff to highmem and 
shrink the "struct page", or we'll just say "screw those 16GB+ machines on 
x86". 

		Linus

