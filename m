Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSEQSms>; Fri, 17 May 2002 14:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316645AbSEQSms>; Fri, 17 May 2002 14:42:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:520 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316644AbSEQSmq>;
	Fri, 17 May 2002 14:42:46 -0400
Message-ID: <3CE54EE0.70FB57E9@zip.com.au>
Date: Fri, 17 May 2002 11:41:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Rusty Russell <rusty@rustcorp.com.au>, Ghozlane Toumi <ghoz@sympatico.ca>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: <E178eCw-0008ML-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0205171111381.26436-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Fri, 17 May 2002, Rusty Russell wrote:
> 
> > I don't care about the bloat: I care about the compile time exploding
> > because every file is different in different trees, due to the
> > filename strings.
> >
> > It'd be very nice to have a solution to this, and I'll keep sending
> > patches to Linus until he applies them or says "no do it this way".
> 
> Well, a way to work around this would be to replace
> 
>         -I$(TOPDIR)/include
> 
> with
> 
>         -I../../include
> 
> on the command line, I suppose, with the right amount of "../". A bit
> hackish, but it should do.

Almost..  The final solution to all problems is to merge
kbuild-2.5 and then to teach it to use relative pathnames
when performing a build within the source tree.  Presumably
that's not hard, but I'm surely about to learn why it's
not feasible.

-
