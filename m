Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286069AbRLHXlF>; Sat, 8 Dec 2001 18:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286072AbRLHXk4>; Sat, 8 Dec 2001 18:40:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286069AbRLHXkp>; Sat, 8 Dec 2001 18:40:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Typedefs / gcc / HIGHMEM
Date: 8 Dec 2001 15:40:24 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9uu8d8$spc$1@cesium.transmeta.com>
In-Reply-To: <200112081838.TAA19684@webserver.ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200112081838.TAA19684@webserver.ithnet.com>
By author:    Stephan von Krawczynski <skraw@ithnet.com>
In newsgroup: linux.dev.kernel
>                                                                       
> if (tp->rx_buffers[entry].mapping !=                                  
>    le32_to_cpu(tp->rx_ring[entry].buffer1)) {                         
>                                                                       
> The first is u64, the second u32. Either the u64 value is not         
> required, or the statement is broken. Astonishing there is _no_       
> compiler warning in this line.                                        
> 

Why should there be?  The u32 value gets promoted to u64 before the
comparison is done.

> BTW, my personal opinion to "typedef unsigned int u32" is that it     
> should rather be "typedef unsigned long u32", but this is religious.  

I see you have a background in environments where you move between 16-
and 32-bit machines.  Guess what, in Linux the major movement is
between 32- and 64-bit machines, and "unsigned int" is consistent,
whereas "unsigned long" isn't (long is 32 bits on 32-bit machines, 64
bits on 64-bit machines.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
