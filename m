Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264356AbRF2XQG>; Fri, 29 Jun 2001 19:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264035AbRF2XP5>; Fri, 29 Jun 2001 19:15:57 -0400
Received: from jalon.able.es ([212.97.163.2]:1954 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264498AbRF2XPo>;
	Fri, 29 Jun 2001 19:15:44 -0400
Date: Sat, 30 Jun 2001 01:20:17 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Cc: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: VM behaviour under 2.4.5-ac21
Message-ID: <20010630012017.A5048@werewolf.able.es>
In-Reply-To: <3B3C95AF.9D125337@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B3C95AF.9D125337@TeraPort.de>; from Martin.Knoblauch@TeraPort.de on Fri, Jun 29, 2001 at 16:50:23 +0200
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010629 Martin Knoblauch wrote:
>Hi,
>
> just something positive for the weekend. With 2.4.5-ac21, the behaviour
>on my laptop (128MB plus twice the sapw) seems a bit more sane. When I
>start new large applications now, the "used" portion of VM actually
>pushes against the cache instead of forcing stuff into swap. It is still
>using swap, but the effects on interactivity are much lighter.
>

I was just going to say the same. After ac20, I think, the kernel stopped
pre-allocating swap.
Before I had always some swap used even if I was only using half my core memory
(256Mb). And growing. I have not seen the box touch the swap since ac20.
It uses all the ram it can get for cache, but does not send anything  to swap
to use its ram for cache.
Now running ac21 while building ac22, and state is:
werewolf:/usr/src# free
             total       used       free     shared    buffers     cached
Mem:        255588     241044      14544       2168       8836     153752
-/+ buffers/cache:      78456     177132
Swap:       152576          0     152576
werewolf:/usr/src# vmstat
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0      0   6944   8836 153868   0   0    16    12   95   385  17   3  80

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac21 #1 SMP Fri Jun 29 16:02:22 CEST 2001 i686
