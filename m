Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272691AbRHaN5u>; Fri, 31 Aug 2001 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272692AbRHaN5j>; Fri, 31 Aug 2001 09:57:39 -0400
Received: from babel.zehc.net ([213.36.100.145]:27591 "EHLO
	WormHole.Intra.ZEHC.Net") by vger.kernel.org with ESMTP
	id <S272691AbRHaN5W>; Fri, 31 Aug 2001 09:57:22 -0400
Message-ID: <3B8F97ED.2030803@chez.com>
Date: Fri, 31 Aug 2001 15:58:05 +0200
From: Radu-Adrian Feurdean <raf@chez.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010823
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: linux.kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation? [PATCH]
In-Reply-To: <200108310334.f7V3YZm442148@saturn.cs.uml.edu> <Pine.LNX.4.30.0108302117150.16904-100000@anime.net> <l4nnm9.rqp.ln@schlich.user.dfncis.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wolfram@schlich.org wrote:
> Dan Hollis <goemon@anime.net> wrote:
> 
>>On Thu, 30 Aug 2001, Albert D. Cahalan wrote:
>>
>>>Don't go blaming Linux when power supply upgrades sometimes
>>>make this problem go away. You could also try one of the
>>>recent SiS or ALi chipsets.
>>>I just saw a reference (maybe www.tomshardware.com) to AMD's new
>>>chips having trouble on VIA boards -- I'd guess that the Palimino
>>>core can push the motherboard too hard without fancy Athlon code.
>>>
> 
>>So what happens when someone is able to duplicate the problem on say AMD
>>760MP chipset with registered ECC PC2100 ram and 450W power supply?
>>
> 
>>Not to say it has happened yet (I havent got my dual Tyan Tiger MP yet :-)
>>
> 
> it has happened to me. dual athlon mp 1.2ghz w/ crucial reg. ddr sdram.
> after setting CONFIG_MK7 to CONFIG_MK6 all works fine.

The following worked for me (Duron@800, Epox 8KTA2L)

root@WormHole:/usr/src# diff -u linux-2.4.9/arch/i386/lib/mmx.c{~,}
--- linux-2.4.9/arch/i386/lib/mmx.c~	Tue May 22 19:23:16 2001
+++ linux-2.4.9/arch/i386/lib/mmx.c	Fri Aug 31 15:51:58 2001
@@ -97,7 +97,7 @@
  	return p;
  }

-#ifdef CONFIG_MK7
+#if 0

  /*
   *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and

-- 
Radu-Adrian Feurdean
mailto: raf@chez.com
------------------------------------------------------------------------------
+#if defined(__alpha__) && defined(CONFIG_PCI)
+       /*
+        * The meaning of life, the universe, and everything. Plus
+        * this makes the year come out right.
+        */
+       year -= 42;
+#endif
     -- From the patch for 1.3.2: (kernel/time.c), submitted by Marcus Meissner

