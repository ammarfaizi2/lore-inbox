Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVJ2TqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJ2TqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVJ2TqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:46:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39176 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750756AbVJ2TqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:46:17 -0400
Date: Sat, 29 Oct 2005 21:46:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5-mm1: reiser4: ICE with gcc 2.95
Message-ID: <20051029194616.GL4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.6.14-rc5-mm1 with gcc 2.95 and 
CONFIG_REISER4_DEBUG=y results in the following ICE:

<--  snip  -->

...
  CC      fs/reiser4/plugin/space/bitmap.o
fs/reiser4/plugin/space/bitmap.c: In function `parse_blocknr':
fs/reiser4/plugin/space/bitmap.c:608: Internal compiler error:
fs/reiser4/plugin/space/bitmap.c:608: internal error--unrecognizable 
insn:
(insn 93 266 269 (parallel[ 
            (set (reg:SI 0 %eax)
                (asm_operands ("") ("=a") 0[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("fs/reiser4/plugin/space/bitmap.c") 603))
            (set (reg:SI 1 %edx)
                (asm_operands ("") ("=d") 1[ 
                        (reg:DI 1 %edx)
                    ] 
                    [ 
                        (asm_input:DI ("A"))
                    ]  ("fs/reiser4/plugin/space/bitmap.c") 603))
        ] ) -1 (insn_list 83 (nil))
    (nil))
make[2]: *** [fs/reiser4/plugin/space/bitmap.o] Error 1
make[1]: *** [fs/reiser4] Error 2
make: *** [fs] Error 2

<--  snip  -->

Although this is technically an error in gcc 2.95, the code should be 
fixed to work around this issue since gcc 2.95 is a supported compiler 
for compiling kernel 2.6.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

