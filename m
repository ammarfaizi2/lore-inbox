Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSEZP0Q>; Sun, 26 May 2002 11:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316162AbSEZP0P>; Sun, 26 May 2002 11:26:15 -0400
Received: from inje.iskon.hr ([213.191.128.16]:5001 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S316161AbSEZP0O>;
	Sun, 26 May 2002 11:26:14 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>, cr@sap.com
Subject: 2.5.18 / ext3 / oracle trouble
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 26 May 2002 17:26:07 +0200
Message-ID: <877klr2ank.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After lots of testing, I can say that 2.5.18 works great in all three
modes of ext3 for all but one purpose. Oracle database still gets
corrupted during insert load. More precisely, online redo log gets
corrupted, database panics and restore is in order.

This leads me to thinking that there's something wrong with sysv
shared memory in 2.5.x. Although the problem could also be in fsync()
or swap_out() & co. paths, it's yet to be discovered.

It could also be that journaled mode helps the trouble, and it could
be that some swapping makes it more certain, but none of these two
facts are proved for sure. Take it as an observation.

Christoph, I don't know if you're still taking care of shmem in 2.5.x,
so take my apologies if you didn't want to see this email.

Regards,
-- 
Zlatko
