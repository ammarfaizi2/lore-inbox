Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275803AbRJBEsH>; Tue, 2 Oct 2001 00:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275805AbRJBEr5>; Tue, 2 Oct 2001 00:47:57 -0400
Received: from www.transvirtual.com ([206.14.214.140]:50704 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S275803AbRJBErl>; Tue, 2 Oct 2001 00:47:41 -0400
Date: Mon, 1 Oct 2001 21:47:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: New Input PS/2 driver 
Message-ID: <Pine.LNX.4.10.10110012137390.23031-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. It is not that new since I have been using it for several months now
with now problems. I just ported from console project CVS to 2.4.10.
Basically this patch address the issues people have been having with the
current PS/2 driver. Plus it has the bonus of using the universal input
api. It even allows for unpluging the keyboard with no problem and you can
have two keybaord plugged in at the same time with no problems. NOTE:
don't have both keyboard plugged in at boot time. It confusses them. 
The olnly thing which I haven't had time to do is support PS/2 based
keybards that don't use the standard IRQ and port ranges. Several mips
devices have this issue. The patch is 60 K so I posted a link. To use the 
keyboard driver you need to 

1) enable the input core and keyboard support in the input menu. 

2) In the character menu select PS/2 port support and i8042 aux+kbd
   controller. Their are hooks for other types of PS/2 "clones" on other
   platforms.

3) You have 3 different devices to select from. I don't think I have to
   explain them.

   XT keyboard.
   AT and PS/2 keyboards
   PS/2 mouse
   
Here is the diff.

http://www.transvirtual.com/~jsimmons/input-ps2.diff

P.S
  For assumment I have a funny movie clip in the same area(dancemonkeyboy.mpeg).

