Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRDUPHj>; Sat, 21 Apr 2001 11:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDUPH3>; Sat, 21 Apr 2001 11:07:29 -0400
Received: from stanis.onastick.net ([207.96.1.49]:21772 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132684AbRDUPHS>; Sat, 21 Apr 2001 11:07:18 -0400
Date: Sat, 21 Apr 2001 11:07:17 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl
Subject: Re: Athlon problem report summary
Message-ID: <20010421110717.A5804@sigkill.net>
In-Reply-To: <20010420203029.C20176@sigkill.net> <E14qlMO-0002bj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qlMO-0002bj-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a set of programs to tune the MMX code. Arjan I suspect did similar
> when he reoptimised the code for the newer Athlon. Simple stuff like

Alan - your proggy ran (no output) for about 5 seconds or so, then exited.

Arjan - from yours, I get the results below.  Either way, no OOPs, no
errors, etc.  (Felt pretty silly as I remounted all my drives and brought
it back up to multi-user mode ;) ..)

So am I correct in assuming at this point that MMX is working fine on this
mobo/chip combo?  What's next?


Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 16151 cycles per page
clear_page function '2.4 non MMX'        took 11893 cycles per page
clear_page function '2.4 MMX fallback'   took 11736 cycles per page
clear_page function '2.4 MMX version'    took 10436 cycles per page
clear_page function 'faster_clear_page'  took 4998 cycles per page
clear_page function 'even_faster_clear'  took 4881 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 17595 cycles per page
copy_page function '2.4 non MMX'         took 26701 cycles per page
copy_page function '2.4 MMX fallback'    took 26708 cycles per page
copy_page function '2.4 MMX version'     took 17649 cycles per page
copy_page function 'faster_copy'         took 10480 cycles per page
copy_page function 'even_faster'         took 10464 cycles per page


-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
