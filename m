Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSCWBWj>; Fri, 22 Mar 2002 20:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293182AbSCWBPK>; Fri, 22 Mar 2002 20:15:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292841AbSCWBOy>;
	Fri, 22 Mar 2002 20:14:54 -0500
Date: Fri, 22 Mar 2002 16:47:05 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Few kernel 2.4.18 problems with high ram
Message-ID: <Pine.LNX.4.10.10203221640590.17245-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi All

I know that you must be busy with other things but I'm very concerned
about a couple of issues that I'm having on 2.4.18.
I am not sure if you remember but I emailed a while back about having a
problem with 16gb of ram, and you were right it was the bios issue, Intel
just doesn't keep their bioses updated. And now I'm having another problem
with 16gb, I know that the rule is to make double the swap of the ram, but
in this case 32gb of swap is a little out of hand, so I created 4gb of
swap instead. When all the 16gb of ram is used up, the load starts to
shoot up to a point where the machine can't be accessed for a while, then
after an hour or two it comes back down like nothing ever happened. By
looking at top I see that over 15gb of that ram is in cache, can there be
a problem with it giving back the used ram, can I define the cache max? If
I dissable the swap everything seems to function okay, except for one
problem with Oracle, it dies with an "unaccessible memory error", it seems
to only happen when most memory is in cache. I have 2 identical machines
with identical ram,  one shows a little more then the other, is that
normal? Below is a top output from both machines..

First machine...

119 processes: 118 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
CPU1 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU2 states:  0.0% user,  8.0% system,  0.0% nice, 91.4% idle
CPU3 states:  1.0% user,  8.2% system,  0.0% nice, 90.2% idle
Mem:  16020996K av, 15979828K used,   41168K free,       0K shrd,   53024K
buff
Swap:       0K av,       0K used,       0K free                 15252792K
cached

reg00: base=0xe6000000 (3680MB), size=  32MB: uncachable, count=1
reg01: base=0xe8000000 (3712MB), size= 128MB: uncachable, count=1
reg02: base=0xf0000000 (3840MB), size= 256MB: uncachable, count=1
reg03: base=0x3fc000000 (16320MB), size=  64MB: uncachable, count=1
reg04: base=0x00000000 (   0MB), size=16384MB: write-back, count=1


Second machine...

84 processes: 83 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user,  1.0% system,  0.0% nice, 97.0% idle
CPU1 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU2 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU3 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
Mem:  15922812K av, 6430104K used, 9492708K free,       0K shrd,   31196K
buff
Swap:       0K av,       0K used,       0K free                 6084240K
cached

Strange, but this box has mtrr comipled in to the kernel but doesn't have
/proc/mtrr


Anyhow, I hope this is enough information. Please let me know if you need
something else from me.

Thanks.

---------------------
Eugene Chupkin
Systems Engineer
Credit.Com, Inc.
eugene@credit.com
Tel.(510)545-1006
Fax.(510)748-3715

