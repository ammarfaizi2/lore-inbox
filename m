Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDAUZy>; Sun, 1 Apr 2001 16:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRDAUZp>; Sun, 1 Apr 2001 16:25:45 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:16164 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132552AbRDAUZe>; Sun, 1 Apr 2001 16:25:34 -0400
Message-ID: <3AC78E24.98DEA986@sgi.com>
Date: Sun, 01 Apr 2001 13:23:00 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: unistd.h and 'extern's and 'syscall' "standard(?)"
In-Reply-To: <3AC75DBF.31594195@sgi.com> <jelmpktors.fsf@hawking.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Don't use kernel headers in user programs.  Just use syscall(3).
> 
> Andreas.
---
	I'm on a SuSE71 system and have all the manpages installed:
law> man syscall
No manual entry for syscall

	The problem is not so much for user programs as library
writers that write support libraries for kernel calls.  For 
example there is libcap to implement posix capabilities on top
of the kernel call.  We have a libaudit to implement posix-auditing
on top a a few kernel calls.  It's the "system" library to system-call
interface that's the problem, mainly.  On ia64, it doesn't seem
like there is a reliable, cross-distro, cross architecture way of
interfacing to the kernel.

	In saying "use syscall(3)" (which is undocumented on
my SuSE system, and on a RH61 sytem), implies it is in some
library.  I've heard rumors that the call isn't present in RH
distros and they claim its because it's not exported from glibc.
Then I heard glibc said it wasn't their intention to export it.
(This is all 2nd hand, so forgive me if I have parties or details
confused or mis-stated). It seems like kernel source points to an 
external source, Vender points at glibc, glibc says not their intention.
Meanwhile, an important bit of kernel functionality --
being able to use syscall0, syscall1, syscall2...etc, ends up
missing for those wanting to construct libraries on top of the
kernel.

	I end up being rather perplexed about the correct course
of action to take.  Seeing as you work for suse, would you know
where this 'syscall(3)' interface should be documented?  Is it
supposed to be present in all distro's?  


Thanks,
-linda
-- 
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
