Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbTITU2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTITU2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:28:17 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:36482
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261951AbTITU2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:28:13 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Process in D state (was Re: 2.6.0-test5-mm2)
Date: Sat, 20 Sep 2003 15:34:36 -0400
User-Agent: KMail/1.5
References: <20030914234843.20cea5b3.akpm@osdl.org>
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MvKb/tsV2KQy1Vd"
Message-Id: <200309201534.36362.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_MvKb/tsV2KQy1Vd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2.6.0-test4 was pretty solid for me.  My main gripe was the weird key repeat 
problem I've mentioned before (where sometimes a key up event will get missed 
or delayed for no apparent reason, happens about twice an hour in normal 
laptop usage).

I upgraded to 2.6.0-test5, but USB didn't work (I bought a scanner), so I 
tried -mm2 and USB is back and happy.

But, twice in a row now I've made this happen:

 1391 pts/1    S      0:00 /bin/bash
 1419 pts/1    S      0:00 /bin/sh ./build.sh
 1423 pts/1    S      0:00 /bin/bash 
/home/landley/pending/newfirmware/make-stat
 1447 pts/1    D      0:04 tar xvjf 
/home/landley/pending/newfirmware/base/linux
 1448 pts/1    S      0:37 bzip2 -d

All I have to do is run my script, it tries to extract the kernel tarball, and 
tar hangs in D state.

How do I debug this?  (Is there some way to get the output of Ctrl-ScrLk to go 
to the log instead of just the console?  My system isn't currently hung, it's 
just got a process that is.  This process being hung prevents my partitions 
from being unmounted on shutdown, which is annoying.)

Other miscelanous bugs: cut and paste only works some of the time (it pastes 
blanks other times, dunno if this was -test5 or -mm2; it worked fine in 
-test4).

The key repeat problem is still there, although still highly intermittent.

The boot hung enabling swap space once.  I don't know why.  (Init was already 
running and everything...)

Rob

[landley@localhost landley]$ cat /proc/modules
orinoco_cs 6472 1 - Live 0xcc06f000
orinoco 39908 1 orinoco_cs, Live 0xcc07c000
hermes 7744 2 orinoco_cs,orinoco, Live 0xcc06c000

[landley@localhost landley]$ cat /proc/version
Linux version 2.6.0-test5-mm2 (landley@localhost.localdomain) (gcc version 
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 Fri Sep 19 00:35:46 EDT 2003


--Boundary-00=_MvKb/tsV2KQy1Vd
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.bz2"

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
cKEgmvr2Dg==

--Boundary-00=_MvKb/tsV2KQy1Vd--

