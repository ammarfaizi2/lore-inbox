Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292326AbSBPIwY>; Sat, 16 Feb 2002 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBPIwP>; Sat, 16 Feb 2002 03:52:15 -0500
Received: from central.caverock.net.nz ([210.55.207.1]:65042 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S292326AbSBPIv7>; Sat, 16 Feb 2002 03:51:59 -0500
Date: Sat, 16 Feb 2002 21:51:02 +1300 (NZDT)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: linux-kernel@vger.kernel.org
Subject: What? Clock Slowdown Again?
Message-ID: <Pine.LNX.4.21.0108201013170.4109-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


==== Problem One ====
Hi all.  I started noticing the "clock slowdown" problem when I started with
2.4.x series of kernels, and described it in a past post.  In summary, under
framebuffer mode, when the interrupts are disabled, they don't get re-enabled
quickly enough to make sure the system clock keeps up.  I was told about a
patch that would help to solve this, I applied said patch (2.4.3) then, when
the kernel updated to 2.4.11, I was pleased to see the Andrew Morton patch
integrated into the kernel.  

However, I'm noticing the slowdown again, though not to the same extent.  I
took the kernel up to 2.4.17 but I need to do some further tests to see what
else I can ferret out. 

==== Problem Two ====

Also, what are the plans for replacing the virt_to_bus / bus_to_virt
functions?  The sourcecode basically says to use pci_map functions, but, being
almost a kernel illiterate (I know how to compile, apply patches, and not much
else) I don't know how to get started on converting.  I thought that
pci_resource_{start,end,len} may also be needed too.  Am I right?

Again, thanks for all your time.  I read KT and found out about why my 2.5.4
kernel refused to compile, fixed that, fixed another couple of things, then
came up against this bus_to_virt problem, which I'd like to get fixed before I
go anywhere with 2.5 - understandable as I just aout live for my 160x64 text
screen 8-)  I use a VESA framebuffer, as the SiS framebuffer code hasn't been
extended to include the 5597/5598 yet.

Must go...now I can FINALLY send this off, six months after originally
composeng it.

Regards, The Viking
(Please, email me as well, the list takes a VERY long time to read, and I
might miss your post...)

--
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!






