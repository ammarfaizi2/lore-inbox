Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292224AbSBBFCv>; Sat, 2 Feb 2002 00:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292225AbSBBFCl>; Sat, 2 Feb 2002 00:02:41 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:22283
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S292224AbSBBFCd>; Sat, 2 Feb 2002 00:02:33 -0500
Message-Id: <5.1.0.14.2.20020201234626.00b03838@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Feb 2002 23:58:00 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: apm.c and multiple battery slots
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Inspiron 8100 and 2.4.13-ac5, with apmd-final. (I'm holding off 
upgrading until I stop seeing so much stuff about VM problems on lkml). It 
has two battery slots, left and right.

If I put the battery in the left slot and run 'apm' I get

AC on-line, battery charging: 84% (4:12)

If I take out the battery and run apm I get

AC on-line, no system battery

If I put it into the right slot I get

AC on-line

and /proc/apm says I have -1% battery free and -1 minutes remaining ;)

--

The battery was designed to go into the right slot, not the left (left is 
where the floppy drive goes).

--

I went to apm.c to look into patching it to support multiple batteries.

I found this function:
static int apm_get_battery_status(which, status, bat, life, nbat <- battery #)

but it's #if 0'd out, and isn't referred to anywhere in the code. I looked 
at the changelog in the file to try to determine when it stopped being 
used, and why, but I found no useful information, and I can't even ask the 
person who did it, since they didn't tell me they did...


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

