Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTKHUec (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263955AbTKHUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:34:32 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30472 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263953AbTKHUea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:34:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
Date: Sat, 8 Nov 2003 22:32:59 +0200
X-Mailer: KMail [version 1.4]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>
References: <Pine.LNX.4.44.0311081043440.1834-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311081043440.1834-100000@home.osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311082232.59175.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 November 2003 20:45, Linus Torvalds wrote:
> On Sat, 8 Nov 2003, Linus Torvalds wrote:
> > That nanosleep restart seems to be broken, and quite frankly,
> > looking at the mess in kernel/posix-timers.c I'm not all that
> > surprised. The code is total and absolute crap. I have no idea how
> > it's even supposed to work.
>
> I'd suggest just removing the regular nanosleep() emulation from
> there. The clock_nanosleep() restart is likely still broken, but at
> least this way the _regular_ nanosleep() system call works correctly,
> and fixing clock_nanosleep() is likely easier since the restart stuff
> doesn't have to worry about _which_ system call it should restart.
>
> Denis, does this work for you?

Does not seem to work, same symptoms 8(

Although I did not do make clean since build system is supposed to be 
fixed. I just patched the tree where kernel was already built,
and rebuild it (make bzImage modules modules_install).

Will apply to pristine test6 tree (or test9 - need to check whether it 
is downloaded or not yet) and retest
--
vda
