Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313756AbSDQJ1t>; Wed, 17 Apr 2002 05:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313768AbSDQJ1s>; Wed, 17 Apr 2002 05:27:48 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:35181 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313756AbSDQJ1s>; Wed, 17 Apr 2002 05:27:48 -0400
Message-Id: <5.1.0.14.2.20020417101412.066cd4a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Apr 2002 10:26:17 +0100
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.8 IDE 36
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
        vojtech@suse.cz, rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CBD2847.6010003@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:46 17/04/02, Martin Dalecki wrote:
>Benjamin Herrenschmidt wrote:
>>My understanding it that Tivo behaves like some Amiga's here
>>and has broken swapping of the IDE bus itself, not the ext2
>>filesystem.
>>On PPC, we still have some historical horrible macros redefinitions
>>in asm/ide.h to let APUS (PPC Amiga) deal with these.
>>Now, the problem of dealing with DMA along with the swapping is
>>something scary. I beleive the sanest solution that won't please
>>affected people is to _not_ support DMA on these broken HW ;)
>
>No: the sane sollution would be to not support swapping disks between
>those systems and other systems.

<disclaimer: rant>

No it isn't. You can't just go removing features people use. Your attitude 
as the new IDE maintainer is a bit distressing.

In the sake of a cleanup you start throwing away one feature after the 
other. IMHO cleanups are not worth feature removal, obviously your opinion 
differs. Hopefully, we will see the features come back but still the 
interim is annoying for some people...

Also, even more distressing is that you seem to be almost completely 
unresponsive to bug reports about your IDE changes completely breaking IDE. 
My email reporting in detail how any post 2.5.7 kernel fails to boot due to 
hanging during IDE device discovery was left unanswered. Off-line I am told 
you responded to another similar bug report trying to shift the blame to 
someone else's code and when it became apparent it was the IDE code you 
just stopped responding. Do you expect everyone to understand IDE and find 
and fix your bugs? A maintainer of a subsystem should work with people to 
find bugs and fix them, not expect users to do that... Your IDE patches 
keep flowing in one after the other but you completely ignore the fact that 
you broke IDE for some people along the way and the chances of it fixing 
itself by accident are minute... and finding the bug is probably getting 
harder with every patch you submit...

This is _not_ what I would expect from a maintainer of such an important 
subsystem!

</rant>

Apologies for the rant but I feel a lot better now.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

