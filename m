Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSLQTqg>; Tue, 17 Dec 2002 14:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSLQTqg>; Tue, 17 Dec 2002 14:46:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38152 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265484AbSLQTqb>; Tue, 17 Dec 2002 14:46:31 -0500
Message-ID: <3DFF80D9.2000405@transmeta.com>
Date: Tue, 17 Dec 2002 11:54:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.3.95.1021217144308.26554A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021217144308.26554A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> You can call intersegment with a full pointer. I don't know how
> expensive that is. Since USER_CS is a fixed value in Linux, it
> can be hard-coded
> 
> 		.byte 0x9a
> 		.dword 0xfffff000
> 		.word USER_CS
> 
> No. I didn't try this, I'm just looking at the manual. I don't know
> what the USER_CS is (didn't look in the kernel) The book says the
> pointer is 16:32 which means that it's a dword, followed by a word.
> 

It's quite expensive (not as expensive as INT, but not that far from
it), and you also push CS onto the stack.

	-hpa


