Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270386AbRH1IGN>; Tue, 28 Aug 2001 04:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRH1IGD>; Tue, 28 Aug 2001 04:06:03 -0400
Received: from ltgp.iram.es ([150.214.224.138]:1408 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id <S270386AbRH1IFv>;
	Tue, 28 Aug 2001 04:05:51 -0400
Date: Mon, 27 Aug 2001 18:52:00 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 3c59x driver
In-Reply-To: <20010825020022.B21339@wiggy.net>
Message-ID: <Pine.LNX.4.21.0108271832320.580-100000@ltgp.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Wichert Akkerman wrote:

> 
> After switching my laptop to a 2.4 kernel I've had it die occasionaly
> and I finally managed to get an oops out of it today (not running X
> makes that a lot simpler :).
> 
> Decoded oops is below. The machine died in the middle of transferring
> a large chunk of data (500Mb or so) via ssh. It did that twice in a row
> now so it seems to be reprocuable.
> 
> This oops was made using 2.4.7ac11 (with freeswan 1.91 patch included
> but which is not used). I get the same problem on 2.4.8ac5 and all
> other 2.4 releases from the last few weeks as well.
> 
> The usual more-info-available-on-request applies. 
> 
> Wichert.
> 
> CPU:    0
> EIP:    0010:[<c01d27c3>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 000005dc   ebx: c2f5c6e0   ecx: 00000006   edx: cae12712
> esi: c1e12812   edi: c5fd4870   ebp: c5fd4940   esp: c125be70
> ds:  0018  es: 0078   ss: 0018
             ^^^^^^^^
You are another victim of the dubious segment reload optimizations...

	Gabriel.



