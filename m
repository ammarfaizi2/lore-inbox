Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQLRK4V>; Mon, 18 Dec 2000 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQLRK4M>; Mon, 18 Dec 2000 05:56:12 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:49167 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S129581AbQLRKz6>;
	Mon, 18 Dec 2000 05:55:58 -0500
Date: Mon, 18 Dec 2000 11:25:29 +0100
From: Stelian Pop <stelian.pop@alcove.fr>
To: linux-kernel@vger.kernel.org
Subject: Driver for emulating a tape device on top of a cd writer...
Message-ID: <20001218112529.B6315@wiliam.alcove-int>
Reply-To: Stelian Pop <stelian.pop@alcove.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've got this idea some time ago, thinking it would really be
a neat thing...

Basically, I would like to be able to use a cdwriter as a tape
device, with software like dump(8) or tar(1). With /dev/tcdw
as name (for example), I'd like to be able to do:
        mt -f /dev/tcdw rewind
        tar cvf /dev/tcdw /
        tar cvf /dev/tcdw /home
        mt -f /dev/tcdw rewind
        mt -f /dev/tcdw fsf 1
        tar xvf /dev/tcdw
        ...

As someone said to me, this seems to exist on some other UNIX
system (don't recall if it was AIX or something else)... But
I didn't find any work on Linux in this direction. 

I'll start to work on this, probably by looking at the cdrecord 
low level code and porting it into kernel space.

The only technical problem I see are simulating the tape filemarks
on the CD. I'm not sure how to do this, maybe there is some
session information which I could use as a filemark... 

What do you think about this project ? Would it be useful ? Feasible ?
Do you know about some similar work I could use ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@alcove.fr>
Alcôve - http://www.alcove.fr
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
