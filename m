Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSJHPFC>; Tue, 8 Oct 2002 11:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJHPE4>; Tue, 8 Oct 2002 11:04:56 -0400
Received: from inje.iskon.hr ([213.191.128.16]:54709 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S261173AbSJHPEp>;
	Tue, 8 Oct 2002 11:04:45 -0400
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
	<874rc4fzml.fsf@atlas.iskon.hr> <87ptulcgzc.fsf@atlas.iskon.hr>
	<200210081338.50495.baldrick@wanadoo.fr>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 08 Oct 2002 17:10:19 +0200
In-Reply-To: <200210081338.50495.baldrick@wanadoo.fr> (Duncan Sands's
 message of "Tue, 8 Oct 2002 13:38:50 +0200")
Message-ID: <dnhefx9db8.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <baldrick@wanadoo.fr> writes:

>> I also observed that other application I use occasionally - LXR (Linux
>> source cross referencing tool) - takes much longer to generate xref
>> database (which is in Berkeley DB files). It works in three passes,
>> where the last one, when it dumps symbols into DB, is interesting. In
>> 2.4 it finishes quickly (it uses 100% CPU, then occasionally syncs the
>> databases - heavy write traffic for a second - then continues), but
>> 2.5 has problems with it (it stucks writing to disk all the time, CPU
>> usage is minimal and process progresses very slowly). Andrew, if
>> you're interested I can send you some numbers to describe the case
>> better.
>
> Hmmm, are you using ext3?  Changes to the meaning of yield sometimes
> make fsync go very slowly.  This problem has been around since 2.5.28,
> and hasn't yet been fixed (As for a fix, Andrew Morton said "I'll sit tight for
> the while, see where shed_yield() behaviour ends up").
>

Yes, it's an ext3 partition, ordered mode. I don't have ext2 compiled
into kernel anymore. :)

Hm, if it's a problem with fsync() then that could explain slight
Oracle slowdown, too, as I think that Oracle is a heavy user of
fsync. But I don't know that for sure. I'll investigate further..

Regards,
-- 
Zlatko
