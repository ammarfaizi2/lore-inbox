Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284309AbRLBUlO>; Sun, 2 Dec 2001 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284348AbRLBUkh>; Sun, 2 Dec 2001 15:40:37 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:4362 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S284309AbRLBUiS>; Sun, 2 Dec 2001 15:38:18 -0500
Date: Sun, 2 Dec 2001 20:32:07 +0000
From: Alan Ford <alan@whirlnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre2 & PCMCIA Errors
Message-ID: <20011202203207.A1014@whirlnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 2.4.17-pre2 (was previously on 2.4.16-pre1) and when pcmcia-cs is
started on bootup, the following happens:

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff:<1>Unable to handle kernel NULL pointer
dereference at virtual address 00000004
 printing eip:
c0118781
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0118781>]    Not tainted
EFLAGS: 00010206
eax: 00000000   ebx: cf57d988   ecx: 00000000   edx: a00fffff
esi: a00fffff   edi: a0000000   ebp: 00100000   esp: cf57d968
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 238, stackpage=cf57d000)
Stack: cf57d988 a0000000 a0000000 c0118854 00000000 cf57d988 cfdc1bc0 a0000000
       00000200 a0000000 a00fffff cfdc1bc0 c01bd035 a0000000 00100000 c01bd03e
       00000000 a0000000 00100000 cfdc1bc0 00000000 cff4e000 c01badb4 a1000000
Call Trace: [<c0118854>] [<c01bd035>] [<c01bd03e>] [<c01badb4>] [<c01bd1cb>]
   [<c01bac34>] [<c01badb4>] [<c01badb4>] [<c01bd180>] [<c01bac34>] [<c01badb4>]
   [<c01badb4>] [<c01bd180>] [<c01bac34>] [<c01badb4>] [<c01bd225>] [<c01bac34>]
   [<c01badb4>] [<c01bae22>] [<c01bac34>] [<c01badb4>] [<c01ba9bc>] [<c01bb012>]
   [<c01bb4eb>] [<c01bb30a>] [<c01bc9a5>] [<c018167b>] [<c01c96b7>] [<c018218e>]
   [<c0185eac>] [<c0185496>] [<c0114646>] [<c01146ab>] [<c0114781>] [<c01149a3>]
   [<c01148f4>] [<c01bcf8b>] [<c0140002>] [<c01bf44f>] [<c019d5eb>] [<c01a3b10>]
   [<c0107cff>] [<c019be15>] [<c015cab5>] [<c015cbc3>] [<c015e34c>] [<c015e575>]
   [<c015ea0d>] [<c01303c3>] [<c0130484>] [<c0130694>] [<c013089f>] [<c0130260>]
   [<c0129838>] [<c0129bdd>] [<c012014a>] [<c01bf08c>] [<c013a828>] [<c013a862>]
   [<c013acbf>] [<c01bef57>] [<c0139e77>] [<c0106b0b>]

Code: 3b 79 04 72 05 3b 71 08 76 05 89 c8 eb 29 90 8d 51 18 8b 02


If I run cardctl, I'll get the same error ("Unable to handle kernel NULL
pointer dereference at virtual address 00000004")

Can anybody enlighten me? Is this a kernel bug or have I got something
misconfigured that just happened to work before (if so, can that "feature"
be put back please? :) )

Am using Debian with pcmcia-cs 3.1.29-3. Laptop is a Dell Insprion 8K 
(CardBus controller is a TI PCI4451).

-- 
Alan Ford * alan@whirlnet.co.uk 
