Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRLRAun>; Mon, 17 Dec 2001 19:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283267AbRLRAud>; Mon, 17 Dec 2001 19:50:33 -0500
Received: from chmls18.ne.ipsvc.net ([24.147.1.153]:32196 "EHLO
	chmls18.ne.ipsvc.net") by vger.kernel.org with ESMTP
	id <S283390AbRLRAuZ>; Mon, 17 Dec 2001 19:50:25 -0500
Subject: Poor performance during disk writes
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 17 Dec 2001 19:53:28 -0500
Message-Id: <1008636811.226.0.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been witnessing what I believe to be poor performance from my
computer ever since I have moved into the 2.4.x kernel versions. Combing
through the unofficial archives of this mailing list reveals some others
having similar problems, but I haven't seen any real resolution, or
maybe their problems are completely different than mine.

The problem simply is that whenever the computer does a big disk write,
everything else is put on hold. Maybe this isn't a problem, but just the
way it was written. I have tested this on a 2.2.x kernel and it also
does it, but to a much lesser extent, to the point that I noticed the
performance loss in the upgrade to a 2.4.x kernel and decided to
investigate further.

But also, I do not have any performance problems with disk reads.
Programs can be loading up all they want and I am able to use my
computer for other things during that time. It just seems to me (maybe
I'm wrong) that the computer should be able to send small bits of data
to the disk for writing during the off cycles and not affect the rest of
the system (which is what I imagine it is doing for reads).

To test, I've got a 142Meg file. I copy it around, makeing sure to copy
from one disk to another. Of course the copy goes fine, because it does
a cache (as I've been reading here), but eventually it needs to write
out to disk (or when I do a sync) and here is where the computer hangs
for a bit. If an mp3 is playing, it halts for 5 seconds at a time, mouse
movement on the screen is VERY jerky, Gkrellm will stop updating for
seconds and even just in console I can't type in stuff for a bit.

I've been using hdparm to try and tweak hard disk access, but I'm not so
sure this is the problem, and it's making me more confused about the
entire situation. hdparm doesn't allow me to set using_dma, which it
seems ought to be a necessity for getting a decent speed out of your
hard drives (not that speed is the problem here), but despite that I
still get a 51MB/s cache read speed in testing. Confusing, is the hard
drive using (u)dma or not? Also, unmaskirq masks things a bit slower.

So, the questions: Is there a way for me to stop this, some configure
option? Is it a bug/performance issue that needs to be addressed in the
kernel? Should I just go back to the 2.2.x kernel series and shutup
already?

I'm running 3 hard drives (30G Maxtor, 20G Seagate, and 2.1G Quantum
Fireball) on an AMD k6-2 3dnow with a Gigabyte GA-5AX MOBO and the ALI
Aladin V chipset.

Thanks for your time and let me know if you need any more info/ output
from dmesg or something.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

