Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHWUCS>; Thu, 23 Aug 2001 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWUCI>; Thu, 23 Aug 2001 16:02:08 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:501 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S266977AbRHWUCC>;
	Thu, 23 Aug 2001 16:02:02 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bob Glamm <glamm@mail.ece.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 23 Aug 2001 22:02:07 +0200
In-Reply-To: Tom Rini's message of "Thu, 23 Aug 2001 12:41:09 -0700"
Message-ID: <d3g0aituio.fsf@lxplus051.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> You've said this before. :) Just how small of an 'embedded'
Tom> system are you talking about?  I know of people who do compile a
Tom> kernel now and again on a 'small' system, for fun.  On a larger
Tom> (cPCI) system, I don't see your point.  If you can somehow
Tom> transport the 21mb[1] bzip2 kernel source to your system, you can
Tom> transport python.  If you're porting to a brand new arch, there's
Tom> still good tests before you have shlib support (You've mentioned
Tom> that before too I think).

I am actually much more concerned about bringing up new systems than
embedded however it is not uncommon to have very limited space to work
in (like 64MB). My point is that the transport process of the kernel
image is painful. Some of the embedded devices or new systems being
brought up may only have serial some do not have network or
floppy. This makes it *very* painful to move things around because you
have to physically move your disk or similar. In particular when
bringing up a system you tend to disable large parts of the kernel in
order to make the thing compile and you don't want to have to copy
things back and forth constantly because you found that serial no
longer compiles and you don't want to fight that while you are trying
to fix a bug in your video driver. Hence you just disable serial and
recompile - with the new system this has suddenly become extremely
painful.

>>  And introduces new problems that so far haven't been addressed.

Tom> Which is what?  The dependancy on python2?

Yes

>> The solution seems to be that someone implements CML2 in C, once
>> that happens we are talking something completely different.

Tom> As long as it does everything the current version does and is
Tom> just as fast I don't think there'll be much of an argument for
Tom> either.  Hell, probably both for a while...

Well getting a C versions means we can get rid of the Python hell, it
would be a major win.

Jes
