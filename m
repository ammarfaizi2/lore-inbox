Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSEGL7a>; Tue, 7 May 2002 07:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEGL73>; Tue, 7 May 2002 07:59:29 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:38088 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S315421AbSEGL72>; Tue, 7 May 2002 07:59:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: psmouse
Date: Tue, 7 May 2002 14:00:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020507115928Z315421-22651+24320@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I already said that I have a Logitech Optical Wheelmouse and that it is not 
detected correctly in 2.5.1[234]-dj1. It is detected as a 'PS/2 Logitech 
Mouse on isa0060/serio1' and the scrollwheel does not work. 

The devicetype for this mouse is 86
after putting this value in the logitech_* arrays it is detected 
as 'ImExPS/2 Microsoft IntelliMouse Explorer on isa0060/serio1'....
and now the scrollwheel works, but only in one direction (opposite to the 
expected direction)...

forcing the detect routine to return PSMOUSE_PS2PP directly after the 
logitech detection stuff I get a lot of these messages:
psmouse.c: Lost synchronization, throwing X bytes away. (with X = 1-3)
and the mouse is not really usable

using some settings for the Microsoft stuff and returning PSMOUSE_PS2PP also 
does not work, but returning PSMOUSE_IMEX results in a usable mouse (again 
with 1 scroll direction)

I don't know how to change the scrollwheel stuff in psmouse_process_packet so 
it works with my mouse, but I know the contents of the packets (in packet[]):

wheel move	| p[0]	| p[1]	| p[2]	| p[3]	| p[4]
--------------------------------------------------------
up		| 8	| 0	| 0	| 15	| 0
down		| 8	| 0	| 0	| 1	| 0


I do not know what to do next, but I want to use my scrollwheel!!
BTW the wheel works in 2.4.x

mouse info:
Logitech Optical Wheelmouse
M/N: M-BJ58
P/N: 830513-0000
S/N: LNA14826942
Chip: CP5763AM, Logitech, 3311550000 A  02, IND0143 508226

	Rudmer

