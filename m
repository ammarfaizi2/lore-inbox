Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbRFUD0n>; Wed, 20 Jun 2001 23:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264734AbRFUD0d>; Wed, 20 Jun 2001 23:26:33 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:20475 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264733AbRFUD0X>; Wed, 20 Jun 2001 23:26:23 -0400
From: "Zack Weinberg" <zackw@stanford.edu>
Date: Wed, 20 Jun 2001 20:26:21 -0700
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Message-ID: <20010620202621.C12387@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> If somebody passes in a bad pointer to a system call, you've just
> invoced the rule of "the kernel _may_ be nice to you, but the kernel
> might just consider you a moron and tell you it worked".
> 
> There is no "lost data" or anything else. You've screwed yourself, and
> you threw the data away. Don't blame the kernel.
> 
> And before you say "it has to return EFAULT", check the standards, and
> think about the case of libraries vs system calls - and how do you tell
> them apart?

My reading of the standard is that it has to either return EFAULT or
raise SIGSEGV.  But I am not expert in XPG4-ese.

Whether or not the standard requires anything, I would much rather
that the kernel not silently discard error conditions.

zw
