Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314352AbSD0Seh>; Sat, 27 Apr 2002 14:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314358AbSD0Seg>; Sat, 27 Apr 2002 14:34:36 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:1808 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S314352AbSD0Sef>; Sat, 27 Apr 2002 14:34:35 -0400
Subject: Re: kernel 2.5.10 problems
From: Miles Lane <miles@megapathdsl.net>
To: Tommy Faasen <faasen@xs4all.nl>
Cc: Dave Jones <davej@suse.de>, dmacbanay@softhome.net,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1019894325.420.1.camel@it0>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 Apr 2002 11:32:46 -0700
Message-Id: <1019932366.2001.8.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 00:58, Tommy Faasen wrote:
> On Fri, 2002-04-26 at 02:24, Dave Jones wrote:
> > On Thu, Apr 25, 2002 at 05:58:14PM -0600, dmacbanay@softhome.net wrote:
> > 
> >  > 3.  Starting sometime after kernel 2.5.1 (I couldn't compile any kernels 
> >  > from then up until 2.5.5) the Evolution email program locks up whenever 
> >  > Calender, Tasks, or Contacts is selected.  I have to go to another terminal 
> >  > and kill it. 
> > 
> > Oh, and does this still apply to 2.5.10 ?
> > Again, last few lines from an strace to find out what its doing when it locks
> > up may be useful.
> > 
> I would like to confirm this bug on 2.5.8, 2.4.x is ok, I have to try
> 2.5.10 yet ...

I have been aware of this bug since about 2.5.5.  It is still present 
in 2.5.10.  I have been attempting to gather more useful debugging
information.  So far, I haven't come up with anything that points
clearly to the problem.

Regarding using strace to identify the bug, it should be noted
that Evolution uses multiple processes that all communicate with
the shell process (evolution).  The process that handles access
to much of Evolution's storage for the most of the Evolution
components is called wombat.

My plan is to run "strace wombat", "strace evolution-mail" and
"strace evolution-addressbook" in separate terminal windows.
The evolution process can then be started normally.  

My observations so far lead me to suspect a problem with
wombat.  If any of you other Evolution uses would care to 
help me with this testing, please do!

Thanks,
	Miles

