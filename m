Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276453AbRJYWNu>; Thu, 25 Oct 2001 18:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJYWNl>; Thu, 25 Oct 2001 18:13:41 -0400
Received: from jalon.able.es ([212.97.163.2]:26000 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S276453AbRJYWNY>;
	Thu, 25 Oct 2001 18:13:24 -0400
Date: Fri, 26 Oct 2001 00:13:54 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lost Logic <lostlogic@toughguy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Message-ID: <20011026001354.C2245@werewolf.able.es>
In-Reply-To: <E15wmgp-0005E8-00@the-village.bc.nu> <3BD841B7.5060405@toughguy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BD841B7.5060405@toughguy.net>; from lostlogic@toughguy.net on Thu, Oct 25, 2001 at 18:45:43 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011025 Lost Logic wrote:
>GCC 3.0 Produces slower code, eh?  I was of the understanding that it 
>contained many more optimizations than previous versions...???
>
>Any way, I've been able to run my system based entirely on a fairly 
>recent GCC CVS-3.02 snapshot, including kernels, and everything EXCEPT 
>for glibc which is specifically incompatible according to the GNU folks.  
>
>By way of information however, neither of the GCC 3.0 releases (3.0.0 or 
>3.0.1) work at all on my system, and I cannot get a kernel to function 
>at better than -O2 (not that I could get that to work in 2.95.* or 
>2.96.* either).
>

-O3 activates -finline-functions:
`-finline-functions'
     Integrate all simple functions into their callers.  The compiler
     heuristically decides which functions are simple enough to be worth
     integrating in this way.

     If all calls to a given function are integrated, and the function
     is declared `static', then the function is normally not output as
     assembler code in its own right.

Last paragraph is the key. Perhaps previous gcc'd did not all his work
as the manual says (ie, did not kill the non-inline version, bug),
but people has got used to the bug, and see it as a feature.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre1-beo #1 SMP Thu Oct 25 16:19:19 CEST 2001 i686
