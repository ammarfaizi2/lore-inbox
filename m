Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288323AbSACVPc>; Thu, 3 Jan 2002 16:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSACVPM>; Thu, 3 Jan 2002 16:15:12 -0500
Received: from tourian.nerim.net ([62.4.16.79]:47377 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288258AbSACVPC>;
	Thu, 3 Jan 2002 16:15:02 -0500
Message-ID: <3C34C9D4.4030705@free.fr>
Date: Thu, 03 Jan 2002 22:15:00 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: cs@zip.com.au, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102170833.A17655@thyrsus.com> <E16Lu2i-0005nd-00@the-village.bc.nu> <20020102172448.A18153@thyrsus.com> <3C339219.4040808@free.fr> <20020103144904.A644@zapff.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a stupid post elsewhere in this thread and recognised it. But 
here I'm far from convinced I should have shut my big mouth :-p

Cameron Simpson wrote:

> [...]
> | Reading proc files requires running kernel space code, do we have kernel
> | space code running with *user* priviledge now?
> 
> Oh please don't inject (more) noise into this1 Doing ANYTHING involves
> running kerel space code somewhere.


Nothing to do with my point. You can't make usefull code without kernel 
syscalls sure but you don't need kernel code for most of your code.

We speak of code priviledge here. If you put the whole dmidecode in 
kernel space you make it running at full system level priviledge. So 
there's little difference (and in fact favorable to suid solution) to 
the priviledge level of the running code. Point.

Anyway this thread branch is dead, we didn't understand Eric's point 
which was on the level of priviledge the *user* using the code needs.

> It is still possible to talk
> meaningfully about:
> 
> 	- opening a publicly readable file in /proc to get some info,
> 	  which will run some kernel code (which can presumably be trusted;
> 	  if you don't trust your kernel you have a serious problem)


I have different levels of trusting. For example I trust code I've read 
and understood (somehow did program proof) as much as I trust my 
capability to understand the code. So in short I don't fully trust 
anything but have more confidence in some things (experience running it, 
heard good things from people I *trust*, ...).


>     versus
> 
> 	- running a setuid binary (however audited) to get the info; said
> 	  binary may have bugs, security holes, race conditions etc;


These aren't things kernel code is immune to.

> it may be
> 	  hacked post boot (no so easy to do to the live kernel image), etc
> 


Hacked post boot <- security bug outside of dmidecode. If security is of 
concern this bug should be corrected with or without existance of an 
user-level dmidecode.
You mean probability of bug greater out-of-kernel than in-kernel ? I 
don't deal with such things as bug probabilities on corner cases like 
this, sorry. If you have enough security bugs in a corner case of 
reading (not even writing to) /dev/kmem (BIOS tables, not kernel data) 
to make probabilities I don't trust your systems :-p

> Further, binaries which grovel in /dev/kmem tend to have to be kept in sync
> with the kernel;


Read dmidecode.c, it's an exception.

> in-kernel code is fundamentally in sync.
> 

Wrong, history shows there are always parts of the kernel behind.

LB.

