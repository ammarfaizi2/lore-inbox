Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135702AbRAHMiz>; Mon, 8 Jan 2001 07:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137106AbRAHMiq>; Mon, 8 Jan 2001 07:38:46 -0500
Received: from [139.102.15.43] ([139.102.15.43]:54719 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S135702AbRAHMie>; Mon, 8 Jan 2001 07:38:34 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 07:38:10 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Fix compile warnings in 2.4.0 
Reply-to: richbaum@acm.org
CC: linux-kernel@vger.kernel.org
Message-ID: <3A596E62.7415.1048C8@localhost>
In-Reply-To: Your message of "Sun, 07 Jan 2001 16:19:50 CDT."             <3A589726.5449.291B75@localhost> 
In-Reply-To: <9097.978915147@ocs3.ocs-net>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2001, at 11:52, Keith Owens wrote:

> On Sun, 7 Jan 2001 16:19:50 -0500, 
> "Rich Baum" <baumr1@coral.indstate.edu> wrote:
> >This patch should fix the rest of the warnings about #endif 
> >statements when using the 20001225 gcc snapshot.  Thanks to 
> >Keith Owens for providing a script to automate this process.  It got 
> >the job done sooner and found warnings to fix for non x86 platforms.
> 
> As reported by Neil Booth, your patch contains errors which do not
> appear in my patched system using my script.  You probably skipped the
> leading '^' in the regexp.  It also turns out that there are a couple
> of m68k assembler lines which have a trailing '#' which starts a
> comment on that assembler.  So treat '#' as a comment marker as well.
> 
> Whatever you used, it was not my script.  It should be (with '#' added)
> 
>   find -type f -name '*.[chS]' | \
>     xargs perl -lpi -e 's:^(\s*#\s*endif)\s+([^/\s#].*)$:\1\t/* \2 */:;'
> 
> BTW, until the patch is correct do not bother sending it to Alan Cox or
> Linus, just to linux-kernel..
> 
You're right I left off the first ^.  From know on I'll just go back to my 
method of checking my compile logs for errors and manually fixing 
them.  I'll let other people handle non x86 platforms.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
