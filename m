Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264851AbRFUGLQ>; Thu, 21 Jun 2001 02:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbRFUGLG>; Thu, 21 Jun 2001 02:11:06 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:65157 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264851AbRFUGKx>; Thu, 21 Jun 2001 02:10:53 -0400
Date: Wed, 20 Jun 2001 23:10:50 -0700
From: "Zack Weinberg" <zackw@Stanford.EDU>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Message-ID: <20010620231050.F12387@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15153.28055.544280.527063@pizda.ninka.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 08:44:23PM -0700, David S. Miller wrote:
> 
> Zack Weinberg writes:
>  > Linus Torvalds wrote:
>  > > And before you say "it has to return EFAULT", check the standards, and
>  > > think about the case of libraries vs system calls - and how do you tell
>  > > them apart?
>  > 
>  > My reading of the standard is that it has to either return EFAULT or
>                                       ^^
>  > raise SIGSEGV.  But I am not expert in XPG4-ese.
> 
> Linus is trying to point out: "what is this 'it'?"  Is it glibc or
> what the kernel gives you?

POSIX/XPG doesn't make a distinction between kernel and C library as
far as I see... which is why either a signal or an error return is
permitted by the standard; it depends on where the thing really is
implemented.

>  > Whether or not the standard requires anything, I would much rather
>  > that the kernel not silently discard error conditions.
> 
> But only perhaps from a "quality of implementation" perspective not a
> "correctness" one.

Okay, I'll accept that.

zw
