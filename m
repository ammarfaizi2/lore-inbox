Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbSJGPL3>; Mon, 7 Oct 2002 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbSJGPL2>; Mon, 7 Oct 2002 11:11:28 -0400
Received: from 62-190-219-33.pdu.pipex.net ([62.190.219.33]:18440 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263084AbSJGPLM>; Mon, 7 Oct 2002 11:11:12 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210071525.g97FPWWF010037@darkstar.example.net>
Subject: [FUNNY] Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 7 Oct 2002 16:25:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007144250.A626@ucw.cz> from "Vojtech Pavlik" at Oct 07, 2002 02:42:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip conversation about PS/2 mice]

OK, this is amusing for everybody else, and very irritating for me, but as you're all bound to find it funny, I'm posting it so that you can all have a laugh at my expense:

Whilst capturing all of the DMESG data, I decided it would be a Good Thing (tm) to use a serial terminal, to avoid getting console keypresses in the output.  So, I configured /dev/ttyS0 in /etc/inittab/ and /etc/securetty, to run a getty on the serial port, and allow root login.  No problem there.  Then I needed to transfer a kernel image through the serial port, so I edited back /etc/securetty to how it was, and removed tty1 from /etc/inittab.

Yes, exactly, I removed the tty1 from /etc/inittab, so when I rebooted, I got nothing on the console, after the console font was loaded.

"Ah, no problem, just use another VT!", I can hear you all shouting, which is fine, except for the fact that I disabled them all to save memory, (this is a 4MB RAM machine).

"Boot from a floppy!", somebody is probably shouting - good idea, except that the floppy drive is broken on this laptop

"Re-connect the serial console!", is another Good Idea (tm), and the one I thought of.  Except that /etc/securetty doesn't list /dev/ttyS0 anymore, so I can't log in as root, and there are no other user accounts on the system.

So, the only way to fix the problem is to take apart the laptop, put the hard disk in to another machine, boot another kernel from CD, and add tty1 back in to /etc/inittab.

Anyway, feel free to laugh, it is quite funny after all :-)

Now, where is that screwdriver...

John.
