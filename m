Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264336AbRFTMCf>; Wed, 20 Jun 2001 08:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264355AbRFTMCZ>; Wed, 20 Jun 2001 08:02:25 -0400
Received: from phaistos.phaistosnetworks.gr ([212.251.96.163]:51135 "EHLO
	phaistos.phaistosnetworks.gr") by vger.kernel.org with ESMTP
	id <S264336AbRFTMCP>; Wed, 20 Jun 2001 08:02:15 -0400
Message-ID: <3B30910F.6EDCC7A1@phaistosnetworks.gr>
Date: Wed, 20 Jun 2001 15:03:27 +0300
From: "Kissandrakis S. George" <kissand@phaistosnetworks.gr>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-17 i686)
X-Accept-Language: en, el
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 and gcc v3 final
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I suppose that you allready know it
I have installed gcc v3 released Jun 18 and i tried to compile the
kernel and i got
these errors

in make dep i got several warnings that look like this

/usr/src/linux-2.4.5/include/asm/checksum.h:161:17: warning: multi-line
string literals are deprecated

but finally passed..

in make bzImage i got

timer.c:35: conflicting types for `xtime'
/usr/src/linux-2.4.5/include/linux/sched.h:540: previous declaration of
`xtime'

and compilation stops
if i remove the decleration of xtime in sched.h (remove the 540 line)
the compile
will go on and some compiles after...

time.c: In function `do_normal_gettime':
time.c:41: `xtime' undeclared (first use in this function)

and some other errors
if in time.c include the line 540 from sched.h (the xtime) the
compilation will go on
until the same error on another file
i include again the line 540 from sched.h the compilation goes on etc
etc and after lots
of errors finally i got bzImage

I didnt test bzImage if it boots 

with gcc v2.x the same kernel and kernel config it compiles,Is it a
kernel bug, a gcc
bug or something else (bad installation of gcc, my mistake etc etc)? 

Best Regards


--- 
Kissandrakis S. George                 [kissand@phaistosnetworks.gr]
Network and System Administrator       [http://www.phaistosnetworks.gr/]
Tel:(+30 81) 391882/Fax:(+30 892) 23206
Phaistos Networks S.A. - A DOL Digital Company
