Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318425AbSGSBls>; Thu, 18 Jul 2002 21:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318422AbSGSBkn>; Thu, 18 Jul 2002 21:40:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9890 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318315AbSGSBkl>;
	Thu, 18 Jul 2002 21:40:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, sfr@canb.auug.org.au
Subject: Re: [PATCH] Initcall depends automagic 
In-reply-to: Your message of "Thu, 18 Jul 2002 00:44:21 MST."
             <20020718074421.GN1096@holomorphy.com> 
Date: Fri, 19 Jul 2002 11:29:13 +1000
Message-Id: <20020719014425.7F9F5415E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020718074421.GN1096@holomorphy.com> you write:
> On Thu, Jul 18, 2002 at 05:36:09PM +1000, Rusty Russell wrote:
> > This patch generates initcall ordering based on the theory that if A.o
> > references a symbol in B.o, then B.o's initcall must preceed A.o's.
> 
> Any chance you can post the strongly connected components of the
> dependency graph?

Hmm, I don't have that at the moment, but apply the patch and do a
build, and you'll get a ".defs" file for each .o file, eg
kernel/futex.o.defs which contains U and T lines (as per nm output)
showing what symbols it defines and requires.

Then you can do all the analysis you need 8)

Good luck!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
