Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUGNV7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUGNV7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUGNV7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:59:13 -0400
Received: from web40001.mail.yahoo.com ([66.218.78.19]:50786 "HELO
	web40001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265938AbUGNV7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:59:08 -0400
Message-ID: <20040714215907.93421.qmail@web40001.mail.yahoo.com>
Date: Wed, 14 Jul 2004 14:59:07 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Re: kbuild support to build one module with multiple separate components?
To: Ralf Baechle <ralf@linux-mips.org>
Cc: sam@ravnborg.org, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040709215700.GB4316@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ralf

Thanks for the reply.

I looked through kbuild documentation. This is
a variable called lib-y to build .a, for instance,

lib-y := a.o, b.o

Then lib.a will be produced. However, in this case,
you can build a lib.a for each sub module, but
they will have the same name, I don't know how you
can link them together.

I think the current kbuild system does simplify 
the Makefiles in 2.6, but it also reduces the
flexibility.

-Song

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jul 06, 2004 at 04:00:50PM -0700, Song Wang
> wrote:
> 
> > This is wrong, because kbuild will treat A as
> > independent module. All I want is to treat
> > A as component of the only module mymodule.o. It
> > should be linked to mymodule.o
> > 
> > Any idea on how to write a kbuild Makefile to
> > support such kind of single module produced
> > by linking multiple components and each component
> > is located in separate directory? Thanks.
> 
> That's a limitation in the current kbuild system. 
> You either have to put
> all files into a single directory or if you don't
> want that split your
> module into several independant modules.  What I
> haven't tried is using
> .a libraries but they're generally deprecated in
> kbuild.
> 
>   Ralf
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
