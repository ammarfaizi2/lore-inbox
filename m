Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTLET0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTLET0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:26:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:14776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264289AbTLET0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:26:51 -0500
Date: Fri, 5 Dec 2003 11:26:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause? 
In-Reply-To: <3FD06172.28193.4801EF18@localhost>
Message-ID: <Pine.LNX.4.58.0312051122190.9125@home.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
 <3FD06172.28193.4801EF18@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Kendall Bennett wrote:
>
> Right, and by extension of the same argument you cannot use kernel
> headers to create non-GPL'ed binaries that run IN USER SPACE!

This was indeed one of the worries that people had a long time ago, and is
one (but only one) of the reasons for the addition of the clarification to
the COPYING file for the kernel.

So I agree with you from a technical standpoint, and I claim that the
clarification in COPYING about user space usage through normal system
calls covers that special case.

But at the same time I do want to say that I discourage use of the kernel
header files for user programs for _other_ reasons (ie for the last 8
years or so, the suggestion has been to have a separate copy of the header
files for the user space library). But that's due to technical issues
(since I think the language of the COPYING file takes care of all
copyright issues): trying to avoid version dependencies.

> This exact reasoning is what RedHat (aka Cygnus) has been using for years
> with the Cygwin toolkit for Windows. Although 99% of the code built with
> the GNU compilers and Cygwin includes the glibc runtime library that is
> LGPL, every program *must* include the C runtime library startup code or
> it cannot function. *That* code is pure GPL, and by extension any program
> using the Cygwin libraries is a derived work and must be GPL. If you
> don't like that, by a commercially licensed version of Cygwin from
> RedHat/Cygnus instead.

And this is an area where I think the GPL just isn't the right license to
use - but on the other hand it obviously isn't my decision to make. I'm
not touching Cygwin with a ten-foot pole, and that has nothing to do with
licensing ;)

The GPL just doesn't make a lot of sense for library-like infrastructure.

		Linus
