Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSARVRB>; Fri, 18 Jan 2002 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290829AbSARVQt>; Fri, 18 Jan 2002 16:16:49 -0500
Received: from [216.23.11.247] ([216.23.11.247]:10256 "EHLO seapine.com")
	by vger.kernel.org with ESMTP id <S290824AbSARVQJ>;
	Fri, 18 Jan 2002 16:16:09 -0500
To: linux-kernel@vger.kernel.org
Subject: rm-ing files with open file descriptors
X-Url: http://www.lathi.net
X-Face: +GT&`y}rSVHq>&PvSIvtsy^RC6Agyxq)t+25D#'iTroOnA/'pcE$QD*WU1=WLS*OC\0y-kS
 |k+)w~x<On+~nkw**|X{sAHBiS2:_=w#<!?;UWm4|C05osQ8`jpRF+[o!wRPjV`tiTN~i'XXwZz3w=
 7|j)RyEq{~2v;Ht<;!)b'Ni[A{&xm,Myo6+w+#e
Reply-To: lathi@seapine.com
From: Doug Alcorn <lathi@seapine.com>
Date: 18 Jan 2002 16:11:26 -0500
Message-ID: <87lmevjrep.fsf@localhost.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MDRemoteIP: 192.168.1.158
X-Return-Path: lathi@seapine.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a weird situation with my application where the user deleted all
the database files while the app was still reading and writing to the
opened file descriptor.  What was weird to me was that the app didn't
complain.  It just went merrily about it's business as if nothing were
wrong.  Of course, after the app shut down all it's data was lost.

Since I didn't expect this behavior I wrote a simple little program to
test it[1].  Sure enough, you can rm a file that has opened file
descriptors and no errors are generated.  Interestingly, sun solaris
does the same thing.  Since this is the case, I thought this might be
a feature instead of a bug (ms-win doesn't allow the rm).  So, my
question is where is this behavior defined?  Is it a kernel issue?
Does POSIX define this behavior?  Is it a libc issue?  

I tried to google this, but couldn't think of the right terms to
describe it.  As I'm not on lkm, I would appreciate a CC: to
<doug@lathi.net>.
-- 
 (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
 oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
 |_/  If you're a capitalist and you have the best goods and they're
      free, you don't have to proselytize, you just have to wait. 

