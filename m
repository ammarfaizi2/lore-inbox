Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSECNrQ>; Fri, 3 May 2002 09:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSECNrP>; Fri, 3 May 2002 09:47:15 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:48524 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S313118AbSECNrO>; Fri, 3 May 2002 09:47:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: psmouse
Date: Fri, 3 May 2002 15:47:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020503134714Z313118-22651+22158@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Logitech Optical Wheelmouse and it is not detected correctly in 
2.5.12-dj1. It is detected as a 'PS/2 Logitech Mouse on isa0060/serio1' and 
the scrollwheel does not work. 

when I let the detection function print the devicetype I discovered that the 
devicetype of my mouse is not listed in the logitech_{4btn,wheel,ps2pp} 
arrays (it is 86).

when I put 86 in logitech_wheel[] it is still listed as 'PS/2 Logitech Mouse 
on isa0060/serio1'

when I also put 86 in logitech_ps2pp it is listed as 'ImExPS/2 Microsoft 
IntelliMouse Explorer on isa0060/serio1'....

It appears that it is not recognised in the if statement on line 405, 
printing the numbers in the param[] array gives:
param[0] = 8
param[1] = 0
param[2] = 0
param[3] = 205
param[4] = 246

In every combination of 86 in the logitch_* arrays I get the following 
messages when I use the wheel:
psmouse.c: Lost synchronization, throwing X bytes away. (with X = 1-3)
the mouse does not work correctly for PSMOUSE_{IMPS,IMEX} otherwise the mouse 
and the three buttons work ok.

I do not know what to do next, but I want to use my scrollwheel!!
BTW the wheel works in 2.4.x

mouse info:
Logitech Optical Wheelmouse
M/N: M-BJ58
P/N: 830513-0000
S/N: LNA14826942
Chip: CP5763AM, Logitech, 3311550000 A  02, IND0143 508226

	Rudmer
