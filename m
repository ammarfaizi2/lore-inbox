Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287051AbRL2Cym>; Fri, 28 Dec 2001 21:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287103AbRL2Cyd>; Fri, 28 Dec 2001 21:54:33 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36368 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287099AbRL2CyU>;
	Fri, 28 Dec 2001 21:54:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 14:51:13 -0800."
             <20011228145113.I3727@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 13:54:04 +1100
Message-ID: <8541.1009594444@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 14:51:13 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Fri, Dec 28, 2001 at 09:56:53PM +0100, Kai Germaschewski wrote:
>> A couple of months ago, I came up with an alternative to kbuild 2.5. It 
>> doesn't try to have all the features kbuild 2.5 has, but solves the major 
>> problems with kbuild 2.4. 
>
>So has anyone looked at this?  Is this a viable choice?   I've heard nothing
>since Kai posted this.  Keith?

I looked back through the kbuild mail for Kai's suggestions, I may not
have them all.

RFD: Tracking indirect dependencies [long]

  We knocked this back and forth for a while.  We both agree that
  extracting dependencies after compile is correct, where we differed
  was the mechanism.  In fact I have currently implemented Kai's
  approach (lots of little files) as a stepping stone to storing the
  data in a database.  It turns out that one of the reasons that kbuild
  2.5 is slow is handling all the little files containing dependency
  data.

[PATCH] removal of list-multi

  I agree with the patch but that was December 2000, in code freeze,
  and again in April 2001, AFAICR Linus had said "2.5 soon".  This
  patch is worth resurrecting for 2.4.

Auto detection of changed commands/flags

  That was a decent fix for part of the problem, but it did not address
  tracking user commands nor host compiles.  It did not allow for
  separate source and object trees, for read only source trees, nor did
  it handle the more esoteric cases like modules being built from
  multiple directories.

I am not interested in partial fixes, I want the whole kbuild problem
list to be cleared.  Fixes that only solve part of the problem tend to
be filed and ignored.

Kai, did I miss any of your patches?

