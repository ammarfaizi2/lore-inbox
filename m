Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSIDWgt>; Wed, 4 Sep 2002 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSIDWgt>; Wed, 4 Sep 2002 18:36:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315748AbSIDWgs>; Wed, 4 Sep 2002 18:36:48 -0400
Message-ID: <3D768C0F.7040006@zytor.com>
Date: Wed, 04 Sep 2002 15:41:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
References: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> On 3 Sep 2002, H. Peter Anvin wrote:
> 
> [Sorry HPA, I forgot to cc to linux-kernel the first time.]
> 
> 
>>>P.S.
>>>    Using "bswap" is little bit tricky.
>>>
>>
>>It needs to be protected by CONFIG_I486 and alternate code implemented
>>for i386 (xchg %al,%ah; rol $16,%eax, xchg %al,%ah for example.)
> 
> 
> While it would work, this sequence is overkill. Unless I'm mistaken, the
> only property of bswap which is used in this case is that it swaps even
> and odd bytes, which can be done by a simple "roll $8,%eax" (or rorl).
> 
> I believe that bswap is one byte shorter than roll. In any case, using a
> rotate might be the right thing to do on other architectures.
> 

And again, I think you'll find the rotate faster on at least some x86 cores.

	-hpa


