Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHBNZs>; Thu, 2 Aug 2001 09:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbRHBNZi>; Thu, 2 Aug 2001 09:25:38 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9491 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268922AbRHBNZa>;
	Thu, 2 Aug 2001 09:25:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jack Steiner <steiner@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64
In-Reply-To: Your message of "Thu, 02 Aug 2001 07:42:45 EST."
             <200108021242.HAA02573@fsgi055.americas.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Aug 2001 23:25:34 +1000
Message-ID: <6048.996758734@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001 07:42:45 -0500 (CDT), 
Jack Steiner <steiner@sgi.com> wrote:
>What problems exist with cross compiling.
>We are still using the cross-compiler for all of our building & testing.
>We use:
>	gcc version 2.96-ia64-000717 snap 001117 (plus some patches that Ralf added last Dec).
>
>I know that at some point we need to convert to native builds but right now we
>dont have sufficient bigsur/lion boxes to do that.
>
>We have not seen any problems with the compiler we are using - at least we 
>have not attributed a problem to the compiler.

The changes to the copy_user pipeline code in the latest 2.4.7-ia64
patch break snap 001117 in some circumstances.  There are workarounds
but they require changes to code that is not IA64 related, not
satisfactory.

>Should we upgrade to gcc3.0 yet???

I have not succeeded building a cross compiler ix86 to ia64 for gcc
3.0, using a current CVS tree.  The flow insn code breaks on some type
conversions in cross compile mode, even when using gcc 3.0 as the base
compiler.  Debugging is still in progress.

