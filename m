Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSDDPw7>; Thu, 4 Apr 2002 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSDDPwt>; Thu, 4 Apr 2002 10:52:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4662 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313201AbSDDPwi>; Thu, 4 Apr 2002 10:52:38 -0500
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: moving some boot code out of arch directories
In-Reply-To: <3CAB4C5D.80806@esstech.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 08:46:05 -0700
Message-ID: <m1u1qrqxfm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Champagne <gerald.champagne@esstech.com> writes:

> Eric,
> 
> I'm working with a mips kernel which currently doesn't have support for
> compressed kernels, compiled in command lines, and other things like that.
> I looked into some other arch specific code, and it looks like there are
> quite a few things like this in one arch or another that could be moved
> into common code.  Do you have any thoughts on things that could be moved
> into the common code?

A have some thoughts but nothing to concrete right now.  On every architecture
booting seems to be a completely roll your own solution.  Which I find
very annoying.  This one of the reasons I am also working on general
linux booting linux support.  If we could get as far as a bootloader
that works on multiple architectures perhaps we could start to unify
some of these things.

> One of the reasons I ask is because someone asked about adding compressed
> kernel support to the mips tree, and Ralf's response was:
> 
> "General rant, not directed to you personally.  Right now we've got more
> than half a dozen variations of code to support compressed images throughout
> the kernel.  So I'm not going to accept any new patches for compressed
> images before this mess has been cleaned.  Volunteers :-) "

I think most of the cleanup has been done.  But reducing the number of
copies of zlib was work that someone was doing recently.
 
> I don't how much more of the compressed kernel support can be moved into
> the common directories, but I think things like compiled in command lines
> could be moved into common code.  Since you're very familiar with the
> boot code, do you see anything reasonable that can be done?

I really don't know about compiled in command lines.  To me they have
most value when you can take an external utility and edit the command
line that is compiled into the kernel.

Eric

