Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRFFMJE>; Wed, 6 Jun 2001 08:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbRFFMIy>; Wed, 6 Jun 2001 08:08:54 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:16125 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S261960AbRFFMIi>; Wed, 6 Jun 2001 08:08:38 -0400
Message-Id: <l0313030cb743c5bfd10e@[192.168.239.105]>
In-Reply-To: <0106061316300A.00553@starship>
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com>
 <3B1D5ADE.7FA50CD0@illusionary.com> <991815578.30689.1.camel@nomade>
 <20010606095431.C15199@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 6 Jun 2001 13:07:56 +0100
To: Daniel Phillips <phillips@bonn-fries.net>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Break 2.4 VM in five easy steps
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Did you try to put twice as much swap as you have RAM ? (e.g. add a
>> > 512M swapfile to your box)
>> > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying
>> > that anything less won't do any good: 2.4 overallocates swap even
>> > if it doesn't use it all. So in your case you just have enough swap
>> > to map your RAM, and nothing to really swap your apps.
>>
>> For large memory boxes, this is ridiculous.  Should I have 8GB of
>> swap?
>
>And laptops with big memories and small disks.

Strongly agree.  I have a PowerBook G3 with 320Mb RAM.  The 18Gb HD is
shared between a total of 4 operating systems.  I haven't got space to put
2/3rds of a Gb of swap on it - in fact I use only 128Mb of swap under
Linux, and don't usually have a problem.

MacOS X uses whatever disk space it needs, from the volumes currently
mounted.  MacOS 9.0.4 is configured to run totally without swap.  Windoze
95 is configured to run in it's usual bloated way, from a total of about
1Gb of virtual HD.

I'm glad to report that with the new fixes being worked on at present, swap
usage is relatively minimalist under the test loads I am able to subject my
Athlon to.  With mem=32M, compiling MySQL goes 65Mb into swap at maximum,
during compilation of a particularly massive C++ file.  Compilation takes
2h15m under these conditions, which is a little slow but that's what
happens when a system starts thrashing heavily.

With mem=48M, compilation completes in about 6m30s, which compares well
with the 5-minute "best case" compile time with unrestricted memory
available.  I didn't check the total swap usage on that run, but it was
less than the 65Mb used with mem=32M.  After the monster file had
completed, the swap balance was largely restored within a few files'
compilation - something which doesn't happen with stock 2.4.x.

With mem=32M, I can sensibly load XFree86 v4, KDE 1.2, XMMS, a webcam app
and Netscape 4.6.  XMMS glitches occasionally (not often, and not
particularly seriously) as I switch between 1600x1200x24bpp virtual
desktops, and swapping gets heavy at times, but the system is essentially
usable and avoids thrashing.  This weekend, I'll treat a friend with an
ageing Cyrix machine to the patches and see if she notices the difference -
the answer will probably be yes.

It remains to be seen how industrial-sized applications fare with the
changes, but I strongly suspect that any reaction will be positive rather
than negative.  Industrial applications *should* be running as if no swap
was available, in any case...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


