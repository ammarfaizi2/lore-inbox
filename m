Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287885AbSAHFK3>; Tue, 8 Jan 2002 00:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAHFKB>; Tue, 8 Jan 2002 00:10:01 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:49162 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S287885AbSAHFJt>; Tue, 8 Jan 2002 00:09:49 -0500
Date: Mon, 7 Jan 2002 23:09:44 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020107230944.B19649@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com> <20020103232601.B12884@asooo.flowerfire.com> <20020104140321.51cb8bf0.skraw@ithnet.com> <20020104175050.A3623@asooo.flowerfire.com> <20020105154053.A18545@asooo.flowerfire.com> <20020106164813.23555724.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020106164813.23555724.skraw@ithnet.com>; from skraw@ithnet.com on Sun, Jan 06, 2002 at 04:48:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 04:48:13PM +0100, Stephan von Krawczynski wrote:
[...]
| I read all your LKML mails since beginning of November, could find a lot about
| cpu, configs,tops etc but not a single "cat /proc/interrupts" together with
| uptime.

http://web.irridia.com/info/linux/APIC/

This was published back in the beginning (4/2001), and additional stuff
sent to Alan and Manfred for debugging.  I was pushing my problem on
LKML for a couple of weeks, but without much feedback I'm sticking to my
workaround.

This also feeds back to my earlier thoughts on some kind of LKML summary
page of patches and problem reports for those disinclined to wade
through the high LKML traffic.  It's hard for me, much less you, to go
back through the archives manually...

| According to the ongoings of your mails you seem to try really a lot of things
| to make it work out. I recommend not to intermix the patches a lot. I would
| stay close to marcelo's tree and try _single_ small patches on top of that. If
| you mix them up (even only two of them) you won't be able to track down very
| well, what is really better or worse.

Actually, that's why I don't test -aa.  Whatever Marcelo chooses to
include, I'll trust it in its entirety.  But I've tested, for example,
Linus' locked memory patch, and a couple of Andrew's isolated patches,
all applied to mainline with nothing else.  I can't try -aa because it
has interdependencies and unintentional (I assume) backouts of code.

| One thing I would like to ask here is this (as you are dealing with oracle
| stuff): why does oracle recommend to compile the kernel in 486 mode? I talked
| to someone who uses oracle on 2.4.x and he told me it is even in the latest
| docs. What is the voodoo behind that? Btw he has no freezes or the like, but
| occasional coredumps from oracle processes, which he states as "not nice, but
| no showstopper" as his clients reconnect/retransmit with only a slight delay.
| This may be related to VM, thats why I will try to convince him of some patches
| :-) and have a look at the coredump-frequency.

I haven't had any problems with Oracle at all since Linus' locked memory
patch back in the 2.4.14-15ish days.  This on a 4GB 6-way Xeon with
ext2, reiser, couple of other complications, with the kernel compiled
for P3.  I really don't know what would cause Oracle to misbehave with
an i686 kernel that wouldn't be a kernel bug.

Perhaps a gcc-related bug?  I'm still using 2.91.66 for kernels,
although I've used 2.95.x with no problems.  I'm not touching 2.96.x
with a ten-foot pole, waiting instead for a sane 3.x one of these years.

I think Oracle (the company) is a little short of tooth on Linux
experience, since for example and AFAIK they never discovered the fatal
2.4 locked memory problem -- that took Google's report and to a much
lesser extent my later discovery of the same problem.

-- 
Ken.
brownfld@irridia.com

