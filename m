Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280795AbRKGOG4>; Wed, 7 Nov 2001 09:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280796AbRKGOGq>; Wed, 7 Nov 2001 09:06:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15635 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280795AbRKGOGc>; Wed, 7 Nov 2001 09:06:32 -0500
Message-ID: <3BE94C55.AE42D67E@evision-ventures.com>
Date: Wed, 07 Nov 2001 15:59:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161SuY-000498-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > With the following options enabled we get:
> > -freg-struct-return -mrtd -mregparm=3
> >
> >    text    data     bss     dec     hex filename
> > 1302372  260804  288080 1851256  1c3f78 vmlinux
> >
> > Quite significant difference if you ask me!!!
> 
> 30K is nice have but still a scratch on the surface compared with 500K 8)
> 
> > in a saving of about 2.3% in code size. This may not sound grat in
> > relative
> > numbers, but for a compiler designer this would already sound hilarious
> > and in
> > absolute numbers it's: 29760 bytes. Not withstanding the speed
> > improvement...
> 
> The obvious question is - have you tried running the kernel built like that
> with any asm fixups needed ?

Once a long time ago I tried already to do the fixups myself, and got
to the stage of init starting... It wasn't THAT difficult. However
somehow encouraged by the compiler comparisions between gcc and intel's
free compiler, which use the register passing for anything local
to the actual code, where the speed gains are up to 20% im currently
quite inclined to do the redo and finish the experiment.
BTW.> It's not just asm fixpus that have to be done for this
to work. For example all the c files with -fno-omit-frame-pointer
as additional compilatoin flag have to be looked seriously at
again. And of course UML makes the debugging of at least this easier.

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
