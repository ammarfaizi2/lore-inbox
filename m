Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290973AbSAaGde>; Thu, 31 Jan 2002 01:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSAaGdY>; Thu, 31 Jan 2002 01:33:24 -0500
Received: from rj.SGI.COM ([204.94.215.100]:12454 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290973AbSAaGdN>;
	Thu, 31 Jan 2002 01:33:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Wed, 30 Jan 2002 22:07:20 -0800."
             <20020130220720.I18381@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 17:33:04 +1100
Message-ID: <10220.1012458784@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 22:07:20 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Thu, Jan 31, 2002 at 05:03:11PM +1100, Keith Owens wrote:
>> My point is that full replication of history may be
>> too much detail for anybody except the original developer.  If bk can
>> consolidate a series of patchsets into one big patchset (not patch)
>> which becomes the unit of distribution then the problem of too much
>> history can be solved.
>
>If all you mean is that you don't want to have to tell it what to send,
>yes, it does that automatically.  If you start with 100 changes, 
>I clone your tree, you add 200 more, all I do to get them is say
>
>	bk pull
>
>it will send them all, quickly (works very nicely over a modem or 
>a long latency link like a satellite).

AFAICT this is the heart of Rob's problem.  He (and I) do not want you
to see all 200 changes.  Some changes are dead ends, some are temporary
bug fixes that I know will be replaced later, IOW they are my jottings,
not for public release.  Replicating the lot to everybody is just
polluting the other trees.

OTOH if I can tell bk :-

* Take all the changes in the direct line from 17.1 to 17.37.
* Ignore any extraneous branches off that line.
* Ignore other changes that were applied in the same time period but
  are not on the direct line, I am also making changes to 2.4.18-pre6
  at the same time.
* Generate a consolidated patchset which is visible to the outside
  world.
* Hide anything not explicitly marked as visible.
* When the consolidated patchset comes back from the master tree,
  recognise that it is equivalent to 17.1 through 17.37 on my tree,
  even though nobody else has the individual changes.

Then I can choose to make kdb v2.1 2.4.17 common-2 visible as an
entity (17.1 to 17.37), without telling everybody else what other
changes are going on in my tree.  bk pull only sees the consolidated
changes I want to make visible.

