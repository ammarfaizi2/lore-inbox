Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSFDRxG>; Tue, 4 Jun 2002 13:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSFDRxE>; Tue, 4 Jun 2002 13:53:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1702 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315374AbSFDRwu>; Tue, 4 Jun 2002 13:52:50 -0400
Date: Tue, 4 Jun 2002 13:52:47 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206041752.g54HqlW04012@devserv.devel.redhat.com>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for broken Dell C600 and I5000
In-Reply-To: <mailman.1023209101.6092.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some time ago I had to work around broken BIOS in Dell C600
>> and Linus accepted the patch (it was before Marcelo, IIRC). All this
>> time BIOS writers continued to search for the bottom in the barrel
>> of brokenness and now we have I5000 brain damaged in a similar way.
>> Since I5000 is broken even before it sleeps, I made a different
>> workaround.
> 
> What is the problem this fixes?  I don't have any problems with my
> C600 suspending and resuming (2.4.19pre7-ac4).  Some of the comments
> look BIOS-version-specific... why not just upgrade the BIOS?  (The
> comment I saw referred to version A06, but I have A17!)
> 
> Correct me if I'm missing something here... I didn't read the patch
> too carefully...

There is an explanation in the comments. I am not surprised
that your C600 works, because your kernel has the old workaround
for the C600 specifically (activated by DMI scan).
Upgrades do not help, because: 1) they do not fix the problem,
2) even if they did, many could not do it, 3) even if your C600
worked perfectly, there is a number of 5000's and 5000e's in
the field which are broken.

You can test your C600 with A17 by doing this. Apply the patch
(this removes the old workaround), build, reboot. Without
explicit parameter the new workaround is not activated.
Kill gpm. Verify that psaux is not open by doing
"cat /proc/interrupts". Suspend and resume. Very carefuly
type something - keyboard should be working. Now touch the
touchpad. If your keyboard locks, A17 is no better than A06.
If keyboard continues to work, A17 is good, and you may ignore
the rest of this discussion.

-- Pete

P.S. Your list gateway mangles subjects.
