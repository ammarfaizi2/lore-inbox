Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVIGKA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVIGKA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVIGKA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:00:26 -0400
Received: from ns.firmix.at ([62.141.48.66]:25824 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932095AbVIGKAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:00:25 -0400
Subject: RE: kbuild & C++
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Budde, Marco" <budde@telos.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BE@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4BE@www.telos.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Sep 2005 12:00:07 +0200
Message-Id: <1126087207.24425.55.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW you kill threading.

On Wed, 2005-09-07 at 11:13 +0200, Budde, Marco wrote:
[...]
> >> That would be because the kernel is written in *C* (and some asm),
> *not* C++.
> 
> I cannot see the connection. At the end everything gets converted
> to assembler/opcode. In the user space I can mix C and C++ code

Yup. And exported symbols for the linker.

> without any problems, why should this not be possible in the

Yes, this is a general problem with integrated c/c++ stuff like
Win-Visual C++. People think that they can mix it freely, in fact they
are using *only* C++ (it just happens that some part of the source is
compilable with a C compiler, but since you compile everything with the
C++ compiler pressing F9, no one sees the difference).
Why do you think are all these "#ifdef _cpluplus" stuff in the header
files for?

> kernel mode?

Try linking also in the user space, not only compilation.
Second read in the standards about the difference between hosted and
standalone environments and think on the differences.

> >> There /is/ no C++ support.
> 
> This will be a problem in future. Nearly nobody will start a new

No.

> larger project (driver, user space software, embedded firmware)

We re on linux-kernel@ here, so we don't care *here* for user-space
software (only for the interface - i.e. sys-calls).
And for embedded usage C++ is unsusable in user-space too since it will
ex-bloat the whole software if people simply pull-in usual and/or common
C++ libraries like the STL and use them without knowing how much object
code they explode with it (if used without thinking).

> using non OO languages today. So porting eg. Windows drivers to

Which is again wrong. You can OO software without OO languages (though
you loose some nice features and checking).

> Linux is nearly impossible without C++ support.

Is is impossible anyways since the in-kernel interfaces are probably
quite different (though I don't know anything about ).

> E.g. in my case the Windows source code has got more than 10 MB.
> Nobody will convert such an amount of code from C++ to C.
> This would take years.

First, how much of it is really the source of a kernel driver (in the
sense of a Unix/Linux kernel driver)?
And second, no one expects that you convert your driver source. Just
write it from scratch (since you know the internals of the hardware
quite well it should take only a few weeks).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

