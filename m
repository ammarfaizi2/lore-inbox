Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRKYVWt>; Sun, 25 Nov 2001 16:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281068AbRKYVWk>; Sun, 25 Nov 2001 16:22:40 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:60374 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S281067AbRKYVWb>; Sun, 25 Nov 2001 16:22:31 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200111252122.fAPLMMF01027@ns.home.local>
Subject: [ANNOUNCE] kmsgdump ported to 2.4
To: root@mauve.demon.co.uk
Date: Sun, 25 Nov 2001 22:22:22 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ian,

I finally ported kmsgdump to 2.4 one week later, but now it seems to work. At
least, it dumps the messages on panic() and on SysRQ-D. I had a problem when
LocalAPIC was enabled because the interrupts were not released after the CPU
reset, but it seems to be OK now. I'd like that you test it and tell me if you
encounter bugs in it. At least I found one : after a manual dump of the messages
on the diskette, if you press <I> to display informations, there seems to be a
memory overwrite at the end of the last line. Weird but not the that important
IMHO, given the free time I have to spend on it.

You can download it here :

   http://wtarreau.free.fr/kmsgdump/

I hope it'll help you in debugging your kernel, and perhaps help others
(LKML cc'd).

I couldn't test it in an SMP configuration, and the code tries to stop all CPUs
except the one that is reset, there are chances that it might not properly work.

Good luck ;-)
Willy

