Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSHEOWc>; Mon, 5 Aug 2002 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSHEOWb>; Mon, 5 Aug 2002 10:22:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51981 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318542AbSHEOWb>; Mon, 5 Aug 2002 10:22:31 -0400
Message-ID: <3D4E89D2.7020408@evision.ag>
Date: Mon, 05 Aug 2002 16:21:06 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
References: <1264DE104D6@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:

> PDC20265 works correctly without setting stop-bit in last descriptor
> for reads, as IDE drive signals no more data, and we stop udma engine
> manually in such case. But for writes PDC20265 prefetches beyond last 
> pointer, finds garbage here (probably descriptor crossing 64KB, or
> odd length or ...), and aborts whole transfer in the middle (about 
> 4 bytes before end of real write, when it tries to prefetch beginning 
> of next sector).

What about inserting a trap pointer there? One which would allow to 
determine "overflows" fast? However I don't see a way to trigger 
something as convenient as a simple page fault here.

