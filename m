Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSKVKPd>; Fri, 22 Nov 2002 05:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSKVKPd>; Fri, 22 Nov 2002 05:15:33 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21513 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261686AbSKVKPb>; Fri, 22 Nov 2002 05:15:31 -0500
Message-Id: <200211221013.gAMADpp31088@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: P4 compile options
Date: Fri, 22 Nov 2002 13:04:39 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com> <200211220832.gAM8W4p30533@Port.imtp.ilyichevsk.odessa.ua> <20021122092659.GA13373@suse.de>
In-Reply-To: <20021122092659.GA13373@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 November 2002 07:26, Dave Jones wrote:
> On Fri, Nov 22, 2002 at 11:22:53AM -0200, Denis Vlasenko wrote:
>  > > This is already done in 2.5. (Well, the -march anyways)
>  >
>  > I'd say benefits of compiling p4-optimized code are questionable.
>
> On what grounds ?

I consider 16-byte code alignment as way too big.
P4 zealots can demand even more I guess :(
I will happily change my mind when/if I'll see
favorable speed/kernel size benchmarks. Until then,
I think 4-byte alignment is closest to sanity.

Not exactly P4 related but: if you tell gcc your
processor has cmov, gcc will try to use it.
Results: 
* gcc code is worse with cmov than without
* some CPUs (Cyrix?) have slow cmovs (microcoded?)
* you lose whenever you try to use your code
  on cmov-less CPU.

Dave, I am absolutely sure _you_ do not compile
for P4 needlessly, but lots of ordinary people
do that just to be hip. I wanted to point out
why it may be undesirable.

>  > Are you sure your kernel will run faster, not slower?
>  > Benchmark numbers? Or it's only warm and fuzzy feeling?
>
> The kernel mailing list archives are that way --->
>
>  > Warm and fuzzy feelings of kernels compiled for very new
>  > processors quickly disappear when you try to boot e.g. 486 with
>  > them ;)
>
> "Doctor, it hurts when I do this"

It hurts even more when you need to recompile
gcc,glibc,X,KDE,mozilla,etc etc etc :)
I payed no attention when I compiled stuff on my home Duron...

>From the moment when I tried to revive oldie 486
I started to ./configure everything for 386 ;)
--
vda
