Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316987AbSEWTJO>; Thu, 23 May 2002 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316986AbSEWTJN>; Thu, 23 May 2002 15:09:13 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:43793 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316987AbSEWTJJ>; Thu, 23 May 2002 15:09:09 -0400
Date: Thu, 23 May 2002 21:09:00 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kb25 manual [was Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers in the kernel?]
Message-ID: <20020523190900.GC725@louise.pinerecords.com>
In-Reply-To: <20020523154252.GA24260@louise.pinerecords.com> <Pine.LNX.4.33L2.0205230850080.4119-100000@dragon.pdx.osdl.net> <20020523160136.GC24260@louise.pinerecords.com> <3CED2B11.90301@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 21:50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uz.ytkownik Tomas Szepe napisa?:
> >>| > BTW> one of the reasons I never bothered myself with kbuild-2.5
> >>| > is for example that nio matter how frequently Keith
> >>| > is advertising it - every time I go there to have a look at it
> >>| > at sf what I find is a scatter heap of .tar.gz. The documentation
> >>| > about how to install it makes me nervous, since I would
> >>| > rather just expect a diff and a README how to use it, so I never
> >>| > look after it.
> >>|
> >>| Duh... All you need is the core package (diff #1), the architecture
> >>| independent modifications package (diff #2) and finally diff #3 that
> >>| adds the arch-specific stuff. Everything's in a single list on sf.
> >>|
> >>| then just do s/t like
> >>| cd /usr/src/linux-2.4.19-pre8 && zcat \
> >>| 	../kbuild-2.5-core-14.gz \
> >>| 	../kbuild-2.5-common-2.4.19-pre8-1.gz \
> >>| 	../kbuild-2.5-i386-2.4.19-pre8-1.gz \
> >>| 	| patch -sp1
> >>|
> >>| and read the comprehensive manual in Documentation/kbuild/
> >>|
> >>| What's there to be nervous about?
> 
> Well perhaps lazy would be more adequate to express my feelings.
> First why the hell three different diff files?
> I don't give a damn witt about what the internal
> architecure of it is.

> And I don't wan't to miss any non i386 build. (I have ARM for example as
> well.) I don't wan't to care whatever this is all complete. And I just
> expect the documentation about how to use it right at the top in README or
> INSTALL. I'm a human and humans tend to love to stick to habits. And I
> already got in to the habit of:

Well, if you took the time to look at the code, you'd realize
it's actually very practical. The main package is really just
the very core of the system, something that you needn't touch
at all if going from one kernel revision to another. Obviously,
the "common" patch restructures the Makefile skeleton and other
stuff that is shared across all archs. No need to explain the
arch-specific diff I guess.

So, when upgrading to another kernel release, you end up only
having to "patch -R + patch" the "build recipes" (a couple K),
not the system core (a 1MB diff) that scarcely ever changes.

> - One thing one patch.
> - Something to compile look after README or INSTALL first there.

Well, I guess Keith could add an INSTALL file to the d/l list on sf.
If it's to only read "hey, you grab these 3 files and feed them to
patch," it's not much work and apparently there are people who will
find such info helpful.

> Even the kbuild name isn't intuitive
> new-kernel-build would be more clear.

Who cares about the name, man :)
I mean, as far as I'm concerned, if it's called hrmops55 and does
the thing right, I'm not saying a word against it.

> I really just wan't to see how it works first and I wan't
> to see that it indeed work's better then what I have
> already before I look at how it is done

-> go -> read -> the -> manual -> thankyou :)

> Call me arrogant (and most propably it would be justifyed in
> this case), but this aggressive splitup gives me
> prejudictions about the whole thing simply beeing overdesigned...

It's really not.


T.
