Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278807AbRKIDJp>; Thu, 8 Nov 2001 22:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279190AbRKIDJf>; Thu, 8 Nov 2001 22:09:35 -0500
Received: from ns1.hicom.net ([208.245.180.8]:38411 "EHLO ns1.hicom.net")
	by vger.kernel.org with ESMTP id <S278807AbRKIDJW>;
	Thu, 8 Nov 2001 22:09:22 -0500
Message-ID: <3BEB4929.4CE5E403@pobox.com>
Date: Thu, 08 Nov 2001 22:10:33 -0500
From: Tom Zych <freethinker@DEATHTOSPAMpobox.com>
Organization: Detachment 2702
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18pre21 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: lung@theuw.net, crazed_cowboy@stones.com, kernel@corrosive.freeserve.co.uk,
        freedman@ccmr.cornell.edu
Subject: ECS K7S5A bus problem may be causing file corruption
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Apologies for munged address, I don't have a good spam solution
yet.  No need to CC me.)

There appears to be a marginal bus problem with some ECS K7S5A
boards, which may be contributing to some of the file corruption
problems people have reported.  Try running Memtest86
( http://www.memtest86.com/ ) with the CPU (and possibly FSB)
speed set to 100, then 133.  If 100 is ok and 133 isn't, check out
http://65.66.90.193/K7S5A_Corruption_Fix_V131.pdf (warning: pdf)
for details.  My own machine exhibits completely reproducible
errors using either or both DIMMS when the CPU/FSB speed is
133/133, and no errors at 100/100 or 100/133.

Memtest86 is run from a boot floppy and doesn't use the hard
drives, so this is unrelated to the kernel / IDE.  A couple of
people have had trouble under Linux but not Windows, so this may
not be the only issue.  It should be eliminated on a given machine
before testing kernel patches, though.

Hope this helps,
-- 
Tom Zych
freethinker_DEATHTOSPAM@pobox.com
