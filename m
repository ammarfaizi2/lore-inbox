Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbRFTXOB>; Wed, 20 Jun 2001 19:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbRFTXNv>; Wed, 20 Jun 2001 19:13:51 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:50822 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264672AbRFTXNe>; Wed, 20 Jun 2001 19:13:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, landley@webofficenow.com
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 14:12:24 -0400
X-Mailer: KMail [version 1.2]
Cc: ttabi@interactivesi.com (Timur Tabi),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu>
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <0106201412240B.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 17:20, Albert D. Cahalan wrote:
> Rob Landley writes:
> > My only real gripe with Linux's threads right now [...] is
> > that ps and top and such aren't thread aware and don't group them
> > right.
> >
> > I'm told they added some kind of "threadgroup" field to processes
> > that allows top and ps and such to get the display right.  I haven't
> > noticed any upgrades, and haven't had time to go hunting myself.
>
> There was a "threadgroup" added just before the 2.4 release.
> Linus said he'd remove it if he didn't get comments on how
> useful it was, examples of usage, etc. So I figured I'd look at
> the code that weekend, but the patch was removed before then!

Can we give him feedback now, asking him to put it back?

> Submit patches to me, under the LGPL please. The FSF isn't likely
> to care. What, did you think this was the GNU system or something?

I've stopped even TRYING to patch bash.  try a for loop calling "echo $$&", 
eery single process bash forks off has the PARENT'S value for $$, which is 
REALLY annoying if you spend an afternoon writing code not knowing that and 
then wonder why the various process's temp file sare stomping each other...

Oh, and anybody who can explain this is welcome to try:

lines=`ls -l | awk '{print "\""$0"\""}'`
for i in $lines
do
  echo line:$i
done

> How about a filesystem filter to spit out patches, or a filesystem
> interface to version control?

Explain please?

The patches-linus-actuall-applies mailing list idea is based on how Linus 
says he works: he appends patches he likes to a file and then calls patch -p1 
< thatfile after a mail reading session.  It wouldn't be too much work for 
somebody to write a toy he could use that lets him work about the same way 
but forwards the messages to another folder where they can go out on an 
otherwise read-only list.  (No extra work for Linus.  This is EXTREMELY 
important, 'cause otherwise he'll never touch it.)

The advantage of this way is:

1) We know who sent the patches.  (We get the message with the "from" headers 
intact.)

2) Patch mails have descriptions in them most of the time, at least saying 
why, if not what they do.

3) This way, we know (more or less in realtime) that Linus has gotten a patch 
and applied it to his tree.  (What version and everything.)  It may be backed 
out again later, but we could give him another tool that can do that and 
notify the list...

This way, no mucking about with version control, no extra work for Linus, and 
in fact he doesn't have to worry about keeping track of what patches he's 
applied and when because he has a place he can go check if he forgets.

Now everybody tell me why this won't work. (Sure, all at once, why not...)

Rob
