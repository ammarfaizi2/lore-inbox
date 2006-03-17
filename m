Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWCQSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWCQSzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWCQSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:55:36 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42642 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030258AbWCQSzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:55:35 -0500
Subject: Re: chmod 111
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Warne <nick@linicks.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org>
References: <200603171746.18894.nick@linicks.net>
	 <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com>
	 <200603171811.01963.nick@linicks.net>
	 <1142620004.9478.13.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 13:55:28 -0500
Message-Id: <1142621728.9478.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 10:43 -0800, Linus Torvalds wrote:
> 
> On Fri, 17 Mar 2006, Steven Rostedt wrote:
> > 
> > So I guess if you need to debug a system binary, you need it readable.
> > But I guess that can also be a security problem, and having system
> > binaries not readable, might make you system a little more secure.
> 
> NOTE! The kernel does not guarantee that you can't read execute-only 
> binaries.
> 
> In particular, it's fairly easy to create a shared library that replaces a 
> system library (LD_LIBRARY_PATH) and then just dumps out the binary image.
> 
> So anybody who thinks that 0111 permissions are somehow "more secure" than 
> 0755 is just setting himself up for disappointment.  You're much better 
> off just having all binaries be 0755 and getting the security through 
> other means.
> 
> Basically, you should think of the "executable" bit as a way to say "this 
> file is appropriate for execve(), and btw, that does imply that we'll need 
> to read it into memory too". You should _not_ depend on it for security, 
> although dropping the readability bits will mean that certain -trivial- 
> programs won't be able to read it.
> 
> For example, making a binary unreadable is a perfectly good way to stop a 
> web browser or other interface from exporting it outside the machine: but 
> it's not so much about security as about _accidental_ leaking. 
> 
> So from a security standpoint, you're much better off thinking "executable 
> means readable", than lulling yourself into some false sense of security. 

Yep, I agree whole heartily.  I should have stressed the "little" part
in the above quote. "might make your system a __little__ more secure.".
I didn't want to get into the details that you described, but you are
entirely right.  I just wanted to note that it does stop someone at some
level. But it's more of an annoyance to someone with a little more
experience in hacking into a computer.

But since it does stop some amateur's does give it some weight to
actually do it.  But it is far from actually protecting yourself from a
more devious cracker.

But thanks for the critical disclaimer.

-- Steve


