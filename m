Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273836AbRJTRnD>; Sat, 20 Oct 2001 13:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJTRmw>; Sat, 20 Oct 2001 13:42:52 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:50706 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S273836AbRJTRme>; Sat, 20 Oct 2001 13:42:34 -0400
Date: Sat, 20 Oct 2001 13:42:58 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Krzysztof Oledzki <ole@ans.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in "raid5: measuring checksumming speed"
In-Reply-To: <Pine.LNX.4.33.0110201342410.19999-100000@dark.pcgames.pl>
Message-ID: <Pine.LNX.4.10.10110201337350.7732-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on my two P3 boxes linux chooses pIII_sse but pII_mmx and p5_mmx are
> reported as faster instructions:

tail of linux/include/asm-i386/xor.h:

| /* We force the use of the SSE xor block because it can write around L2.
|    We may also be able to load into the L1 only depending on how the cpu
|    deals with a load to a line that is being prefetched.  */
| #define XOR_SELECT_TEMPLATE(FASTEST) \
|         (cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)

this code should probably be generalized to test for K7 feature flags, as well.


