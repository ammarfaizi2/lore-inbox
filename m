Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271698AbRIGLDh>; Fri, 7 Sep 2001 07:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271707AbRIGLD1>; Fri, 7 Sep 2001 07:03:27 -0400
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:58815 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271698AbRIGLDU>; Fri, 7 Sep 2001 07:03:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: K7/Athlon optimizations on VIA KT133A chipset.
Date: Fri, 7 Sep 2001 04:03:07 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090704030700.00319@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to give it until tonight before I really give up on this, but 
right now the only real explination I have is that the KT133A chipset is 
buggy, but not constistantly buggy, and that there's not a whole lot that 
can be done about it.

Robert might turn something up with his MMX2 programs, from what David 
Hollister said yesterday, it sounds like he may be on to something, I'm 
no developer, my C consists of being able to use "printf("Hello 
World!\n");", and I know absilutely no asm, so I can't contribute 
anything on that front.

There's really four options that I can see if the burnMMX2 programs don't 
turn anything up:

1. If it says KT133A, activate code that disables the relevant 
optimizations.

2. Spend a lot of time getting detailed, exact information from users 
about what exactly their board is reporting and wether or not they have 
problems, so that detailed information can be used to determine wether or 
not to shut off instructions as in #1. This is obviously the cleaner 
solution, but it's a lot of effort for a single buggy chipset. We'd need 
at least 150-200 reports to have semi-reliable data for something like 
this, and it may turn out that there's nothing that can be isolated well 
enough to justify this.

3. Do nothing, and advise users in the help to select i686 or K6-2/3 if 
they have problems with K7/Athlon optimizations.

4. Add a config option that only shows up if someone selects K7/Athlon, 
something to the effect of "Disable buggy optimizations for KT133A 
chipset." And have it selected by default, and advise users in help about 
what the problem is, and that they can try turning this off, but that it 
may not work if they do.

Personaly I'd prefer option #4. #2 would be even better, but again, 
that'll take a lot of time for a single chipset. I've only gotten 25 or 
so reports, and the only thing they did was give me 3 or 4 theories that 
all turned out to be fairly wrong.

BIOS versions are still a candidate, as some people ARE reporting that 
they make a difference. If users having problems want something to try, 
try Award V2.8 BIOS if avalible for your board. Gerbrand van der Zouw 
reports stability with it and Kurt's patch, I don't know if he's tried it 
without the patch, and I don't know what the patch does.

If burnMMX2 and variants turn something up, this is obviously all moot, 
and hopefully something could be done to actually FIX the problem instead 
of putting a band-aid(TM) over it.

Does anyone have any contacts at VIA that might actually be interested in 
getting this fixed?
