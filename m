Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSKVKwW>; Fri, 22 Nov 2002 05:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKVKwW>; Fri, 22 Nov 2002 05:52:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:65181 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263204AbSKVKwU>;
	Fri, 22 Nov 2002 05:52:20 -0500
Date: Fri, 22 Nov 2002 10:54:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: P4 compile options
Message-ID: <20021122105438.GA16662@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com> <200211220832.gAM8W4p30533@Port.imtp.ilyichevsk.odessa.ua> <20021122092659.GA13373@suse.de> <200211221013.gAMADpp31088@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211221013.gAMADpp31088@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 01:04:39PM -0200, Denis Vlasenko wrote:

 > I consider 16-byte code alignment as way too big.
 > P4 zealots can demand even more I guess :(
 > I will happily change my mind when/if I'll see
 > favorable speed/kernel size benchmarks. Until then,

I think there's a misunderstanding here.
The march=pentium4 option is only used when you select
"build me a pentium 4 kernel" You do realise that right?
Generic kernels don't change 1 bit.

 > I think 4-byte alignment is closest to sanity.

You know where to find the Intel P4 optimisation manuals..

 > Not exactly P4 related but: if you tell gcc your
 > processor has cmov, gcc will try to use it.

So what ? Show me a P4 without cmov.

 > Results: 
 > * gcc code is worse with cmov than without
 > * some CPUs (Cyrix?) have slow cmovs (microcoded?)
 > * you lose whenever you try to use your code
 >   on cmov-less CPU.

  <------------ The point.
                              --------------> You.

Cmov is completely irrelevant here.
Sure its still an optional instruction which
should be tested for before use, but until Intel
make a P4 without CMOV, adding march=pentium4
is harmless.
 
 > Dave, I am absolutely sure _you_ do not compile
 > for P4 needlessly, but lots of ordinary people
 > do that just to be hip.

Those are probably the same folks who run Gentoo/Slackware/ or
some-other-compile-everything-myself-because-I've-too-much-time-on-my-hands-distro.
Fine, let them be happy.
If some loon wants a P4 optimised /bin/ls, that's his problem,
but optimisation of key components (like say, the kernel) _is_
important.

 > I wanted to point out why it may be undesirable.

All you've pointed out is that a P4 kernel won't run
optimally on a 486. Well surprise, it won't run at all.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
