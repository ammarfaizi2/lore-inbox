Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932796AbWCQVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWCQVor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWCQVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:44:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36511 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932796AbWCQVor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:44:47 -0500
Date: Fri, 17 Mar 2006 22:44:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Warne <nick@linicks.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
In-Reply-To: <1142621728.9478.20.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0603172243460.829@yvahk01.tjqt.qr>
References: <200603171746.18894.nick@linicks.net> 
 <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com> 
 <200603171811.01963.nick@linicks.net>  <1142620004.9478.13.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org> <1142621728.9478.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > So I guess if you need to debug a system binary, you need it readable.
>> > But I guess that can also be a security problem, and having system
>> > binaries not readable, might make you system a little more secure.
>> 
>> NOTE! The kernel does not guarantee that you can't read execute-only 
>> binaries.
>> 
[..]
>> off just having all binaries be 0755 and getting the security through 
>> other means.
>> 
>> Basically, you should think of the "executable" bit as a way to say "this 
>> file is appropriate for execve(), and btw, that does imply that we'll need 
>> to read it into memory too". You should _not_ depend on it for security, 
>> although dropping the readability bits will mean that certain -trivial- 
>> programs won't be able to read it.
>> 
>Yep, I agree whole heartily.  I should have stressed the "little" part
>in the above quote. "might make your system a __little__ more secure.".

-rws--x--x  1 root root 1847788 Sep 16 14:58 /usr/X11R6/bin/Xorg

I never could figure out what this permission mask was good for.



Jan Engelhardt
-- 
