Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJANcJ>; Tue, 1 Oct 2002 09:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbSJANcJ>; Tue, 1 Oct 2002 09:32:09 -0400
Received: from inje.iskon.hr ([213.191.128.16]:47508 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S261625AbSJANcI>;
	Tue, 1 Oct 2002 09:32:08 -0400
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 01 Oct 2002 15:37:28 +0200
In-Reply-To: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain> (Hugh
 Dickins's message of "Tue, 1 Oct 2002 14:09:22 +0100 (BST)")
Message-ID: <dnk7l2cmav.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Tue, 1 Oct 2002, Zlatko Calusic wrote:
>> 
>> Still having problems with Oracle on 2.5.x (it can't even be started),
>> I devoted some time trying to pinpoint where the problem is. Reading
>> many traces of Oracle, and rebooting a dozen times, I finally found
>> that the culprit is weird behaviour of shmat/shmdt functions in 2.5,
>> when combined with mprotect() calls. I wrote a simple test app
>> (attached) and I'm also appending output of it below (running on
>> 2.4.19 & 2.5.39 kernels, see the difference).
>
> Exemplary bug report!  Many thanks for taking so much trouble to
> reproduce the problem.  Patch below (against 2.5.39) should fix it:
> I'll send Linus and Andrew when I can get hold of a 2.5.40 tree.

Oh, dear sir, but you are the one who solved it eventually. :)
Anyway, I'm glad it worked well and I was helpful.

Looking forward to test/bench Oracle w/ patch applied (and report
further bugs in ext3, fsync() and friends ;)).

Keep up the good work!
-- 
Zlatko
