Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272157AbRHXQEE>; Fri, 24 Aug 2001 12:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272202AbRHXQDx>; Fri, 24 Aug 2001 12:03:53 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:41937 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S272157AbRHXQDh>;
	Fri, 24 Aug 2001 12:03:37 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru> <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3ofp5wr46.fsf@lxplus035.cern.ch> <20010824083728.J14302@cpe-24-221-152-185.az.sprintbbd.net> <d31ym1wjk8.fsf@lxplus035.cern.ch> <20010824085052.K14302@cpe-24-221-152-185.az.sprintbbd.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 24 Aug 2001 18:03:44 +0200
In-Reply-To: Tom Rini's message of "Fri, 24 Aug 2001 08:50:52 -0700"
Message-ID: <d3wv3tv40v.fsf@lxplus035.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Fri, Aug 24, 2001 at 05:42:47PM +0200, Jes Sorensen wrote:
>> The real problems with Perl is that it exercises almost all of your
>> libc, uses floating point math, dlopen() and a lot of other
>> funnies. Successfully running Perl's test suite is a very good
>> indicator for the completeness of your libc. On the other hand gcc
>> and the development toolchain are remarkably easy to accomodate on
>> that front.

Tom> We're getting someplace now.  If you question the ability of the
Tom> platform to make reliable tools such as perl, why do you think
Tom> you'll have good binutils and gcc on the platform?

Maybe because I have ''been there done that''! This is exactly how
things were when we brought up the ia64 port.

Tom> If your
Tom> platform doesn't have dlopen() working then yes, python2 will
Tom> probably be pissed off.  I conceeded this last time too I think.
Tom> If you're trying to bring up a platform compiling a kernel is a
Tom> good test of having lots of things working.  With 2.6 it'll mean
Tom> one more thing is at least somewhat working, dlopen().

Do you have any idea how dlopen() actually works? It requires you to
have dynamic loading working, that means shared libraries ... please
do us a favor and go read the code in glibc in elf/*.c and
sysdep/<some-arch>/dl-machine.h (plus a couple of other
files). Implementing shared library support is ''very interesting''
but it's by far the first thing you do on a new system.

That aside, I am not aware whether Python2 actually requires dlopen to
work well enough to run CML2.

Tom> Or you
Tom> can go and make a CML2 interp in C.  Or sh.  I'm quite happy
Tom> cross compiling stuff until things get a bit farther along on a
Tom> brand spanking new platform.

Well I can tell you that most people would like to compile their
kernels on the host even BEFORE they get shared libraries going.

Ok, I think I have spent enough time on this discussion now, back to
hacking.

Jes
