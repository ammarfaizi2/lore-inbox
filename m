Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUASVZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUASVZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:25:52 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:46672 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S263702AbUASVY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:24:58 -0500
Message-ID: <400C4B17.3000003@samwel.tk>
Date: Mon, 19 Jan 2004 22:24:39 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk> <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk> <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk> <Pine.LNX.4.53.0401191521400.8389@chaos>
In-Reply-To: <Pine.LNX.4.53.0401191521400.8389@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
[...]
> I stand by my assertion that anybody who develops kernel
> modules in C++, including MIT students, is arrogant.
> 
> Let's see if C++ is in use in the kernel. At one time, some
> of the tools that came with it were written in C++ (like ksymoops).
> 
> Script started on Mon Jan 19 15:19:33 2004
> $ cd /usr/src/linux-2.4.24
> $ find . -name "*.cpp"
> $ exit
> exit
> Script done on Mon Jan 19 15:20:25 2004

Just so that you know, the extension .cpp is typically used by Windows 
C++ programmers, on most other environments the usual extensions are .cc 
and .C. If you look for *.cc you find scripts/kconfig/qconf.cc, so the 
kernel toolset is not completely C++-free. Not that all of this matters.

> Well, perhaps the kernel developers were ignorant. They didn't
> write anything in C++. Maybe they were just too dumb to learn the
> language?

It seems you you assume I'm an arrogant Bjarne-hugging C++-lover. Where 
did you get that? It's probably in your mind, where everyone who 
suggests C++ is a Bjarne-hugging C++-lover. I'M NOT IN THE C++ CULT. I'M 
NOT SAYING THAT EVERYONE SHOULD PROGRAM IN C++. Hope this came across, 
you are now officially declared deaf. ;)

> Maybe there is another reason:
> The kernel development languages, as previously stated, were
> defined at the project's inception to be the GNU C 'gcc'
> compiler's "C" and extensions,  and the 'as' (AT&T syntax)
> assembler. Anybody can search the archives for the discussions
> about using C++ in the kernel.

Yeah, definitely. I fully agree that it's not wise to use C++ *in the 
base kernel*. The Linux project needs to maintain overall consistency, 
and one of the means of doing that is using a small, well-defined 
toolset -- in this case, as and gcc. Any large project needs language 
and coding standards.

But we're not talking about the base kernel here. We're not talking 
about migrating the kernel to C++, or even modules that are part of the 
Linux kernel source. We're talking about *independent modules*. The 
kernel exports a module interface, and any binary driver that correctly 
hooks into the interface of the running kernel (using the correct 
calling conventions of the running kernel) and behaves properly (e.g., 
doesn't do stack unwinds over chunks of kernel functions etc.) can hook 
into it and do useful work. If somebody has decided that it would be 
worth it for his project to use C++ (without exceptions, rtti and the 
whole shebang) then so be it, why should you care? It's just binary code 
that hooks into the module interface, using the correct calling 
conventions. It doesn't do dirty stuff -- no exceptions, no RTTI, 
etcetera. It compiles into plain, module-interface conforming assembler, 
that can be compiled with -- you guessed it -- 'as', the AT&T syntax 
assembler. Yes, they're taking a risk. Their risk is that C++ can't 
import the kernel headers, or that C++ might someday need runtime 
support that cannot be ported into the kernel. It's *their risk*, not 
yours. Then why do you have a reason to get religious about this? 
They're not submitting this stuff for inclusion in the Linux source!

> Any person, or group of persons, who is smart enough to
> actually write some kernel code in C++, has proved that
> they are not ignorant. Therefore, they have demonstrated
> their arrogance.

This logic is faulty. It is built upon the premise that (ignorant || 
arrogant). Not listening to warnings of others is not a sign of 
arrogance per se, it is only a sign of the presence of a different 
opinion. It assumes that the kernel developers are always right, and 
that everybody who is smart should listen to them, on penalty of being 
arrogant. Yes, these C++-loving people may be wrong (or they may not 
be), but that does not _automatically_ make them arrogant, they may 
simply have a different opinion -- right or wrong. If they are wrong, 
they are not arrogant, but simply *stupid*. If they are right, they are 
not arrogant either -- they may be arrogant *about it*, but that's just 
a manner of behaviour, and it's up to them if they behave in this way or 
not. Kernel developers do not prescribe what people can do with the 
kernel, this is part of the essence of "free". And as a result of that, 
they do not have the right to declare people arrogant when they do not 
listen. They have the right to *call* them that, but the only result of 
that is that all discussion on matters like these are smothered in 
religious wars. And that's a pity.

-- Bart
