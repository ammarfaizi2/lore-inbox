Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFAHe2>; Sat, 1 Jun 2002 03:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSFAHe1>; Sat, 1 Jun 2002 03:34:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64913 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315406AbSFAHe0>; Sat, 1 Jun 2002 03:34:26 -0400
Date: Sat, 1 Jun 2002 02:34:25 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Kevin O'Connor" <kevin@koconnor.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compile quiet mode
In-Reply-To: <20020531230153.A12477@arizona.localdomain>
Message-ID: <Pine.LNX.4.44.0206010228460.21152-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Answered a follow-up mail and didn't realize that l-k was CC'ed in
 the first one, so here's my reply again.]

>From kai-germaschewski@uiowa.edu Sat Jun  1 02:30:31 2002
Date: Sat, 1 Jun 2002 02:27:48 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
To: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: Kernel compile quiet mode

On Fri, 31 May 2002, Kevin O'Connor wrote:

> > gcc $CFLAGS -DKBUILD_BASENAME=raw -c -o raw.o raw.c
> > gcc $CFLAGS -DKBUILD_BASENAME=pty -DEXPORT_SYMTAB -c -o pty.o pty.c
> > gcc $CFLAGS -DKBUILD_BASENAME=misc -DEXPORT_SYMTAB -c -o misc.o misc.c
> > gcc $CFLAGS -DKBUILD_BASENAME=random -DEXPORT_SYMTAB -c -o random.o random.c
> > gcc $CFLAGS -DKBUILD_BASENAME=vt -c -o vt.o vt.c
> > gcc $CFLAGS -DKBUILD_BASENAME=vc_screen -c -o vc_screen.o vc_screen.c

Not bad, I suppose different people prefer different approaches, anyway. 
There is, however, still redundant output there, the "-o vt.o" and 
"KBUILD_BASENAME=vt" should go away as well too, IMO.

Anyway, I'll be out of town for a couple of days, if you want to see what
I'm up to, take a look at linux-isdn.bkbits.net, linux-2.5.make and
linux-2.5.make-new - What I'm doing for the quiet output is pretty
flexible, it can be easily adapted to things like the above.

I'd surely appreciate if people wanted to test things, if you don't have
bitkeeper but want to give it a shot, I can mail a patch.

(For the visually most prominent change, add "quiet" to your make command
line, or set KBUILD_QUIET=1 in the environment)

--Kai


