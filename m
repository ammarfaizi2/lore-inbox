Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbSJBCdk>; Tue, 1 Oct 2002 22:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbSJBCdk>; Tue, 1 Oct 2002 22:33:40 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:32266 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262946AbSJBCdj>; Tue, 1 Oct 2002 22:33:39 -0400
Date: Wed, 2 Oct 2002 03:39:01 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: willy@debian.org
Subject: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002023901.GA91171@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17wZPh-000NI9-00*RnMxuSCwpDM* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.5.40, our application is getting seemingly very large
flock(LOCK_UN) latencies :

Unlock, took 541386 usecs
Old was 567999237 secs, 131042 usecs
now is 567999237 secs, 672428 usecs
Unlock, took 125083 usecs
Old was 567999237 secs, 699310 usecs
now is 567999237 secs, 824393 usecs
Unlock, took 151245 usecs
Old was 567999237 secs, 825119 usecs
now is 567999237 secs, 976364 usecs

(using gettimeofday ...)

No similar times are observed during the corresponding LOCK_EX call.

Is this just a silly app bug somewhere, or something funny in locks.c ?

More details, testing etc. on request ...

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
