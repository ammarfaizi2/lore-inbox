Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278031AbRJZH7v>; Fri, 26 Oct 2001 03:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278037AbRJZH7k>; Fri, 26 Oct 2001 03:59:40 -0400
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:41722 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278031AbRJZH7c>; Fri, 26 Oct 2001 03:59:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Input on the Non-GPL Modules - legal nonsense
Date: Thu, 25 Oct 2001 23:58:59 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011025062415.AAA15814@shell.webmaster.com@whenever>
In-Reply-To: <20011025062415.AAA15814@shell.webmaster.com@whenever>
MIME-Version: 1.0
Message-Id: <01102523585902.10384@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 October 2001 02:24, David Schwartz wrote:
> >I keep hearing this type of reasoning.  It flat-out doesn't work this way
> > in the legal system.  This is similar to arguing that you didn't really
> > stab someone if you threw the knife instead of holding it. ("But your
> > honor, once the knife left my hand it really wasn't under my control...")
>
> 	What amazes me is that these legal arguments about the control programmers
> have over their software, are coming from the free software community. If
> Microsoft argued that anybody who wanted to write a program to link with
> Windows system DLLs had to give them 2% of the profits, they'd be blasted
> by the press, yet the free software community wants to argue that
> programmers can't use their APIs if they don't have certain licensing
> terms?!
>
> 	The irony is killing me.

It's not a question of the published APIs.  Binary-only modules ARE allowed, 
and nobody's even questioned userspace applications.

It's aggregating yoru code with GPL code and distributing the result.  That 
violates the terms of the GPL, negating your right to distribute the GPL 
code, and by extension the aggregate work containing the GPL code.

And this isn't specific to free software.  Imagine if Microsoft put royalties 
on the distribution of some of their DLLs (like the big visual basic runtime) 
with your program, or Sun put restrictions on shipping their java runtime 
with one of your java programs.  (Which, in fact, they do.)  Neither 
currently ask for cash, but boy do they put restrictions!  Try distributing a 
modified version of either one of those sometime and see how long it takes 
their lawyers to come after you.  Distributing a patched vbrun.dll?  They'll 
go after you with bazookas.  You can't even unarchive jre.exe, last I 
checked.  The end user has to install it on their machine using Sun's 
installer.  (Maybe this has eased up in the past couple years, I stopped 
paying too much attention to Sun's java distributions shortly after 1.2...)

If your code doesn't include any GPL code, you're fine.  User space 
applications linking against glibc are fine, and binary-only kernel modules 
you wrote from scratch yourself are fine.  (Header files that define APIs but 
don't directly produce binary output code by themselves are a gray area; it's 
sloppy of us to have those as GPL instead of LGPL anyway, but compiling 
against header files probably falls under fair use since the programmer did 
make a distinction between .h and .c files, and being included in other 
programs to allow interoperability with this bit of code is what .h files are 
FOR...  I'd guess It's something that either side of could be successfully 
argued in front of a judge, depending on who had the better lawyer...)

Rob
