Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130730AbRBATdU>; Thu, 1 Feb 2001 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130640AbRBATdL>; Thu, 1 Feb 2001 14:33:11 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:64013 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S130535AbRBATc4>;
	Thu, 1 Feb 2001 14:32:56 -0500
Date: Thu, 1 Feb 2001 19:32:50 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel 2.4.1
Message-ID: <20010201193250.B340@kermit.wd21.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first linux bug report :)

As some may have noticed I have been struggling with an MCA machine of the
above type (see subject) for the last couple of days. I installed 2.4.1 to
take advantage of devfs and potentially ReiserFS.

The machine has a 3Com 3c523 Etherlink/MC card installed. It worked under
2.2.17 but I can't load the module in 2.4.1.

When I modprobe 3c523 I get:

eth0: 3c523 adapter found in slot 3
eth0: 3Com 3c523 Rev 0xe at 0x1300
eth0: memprobe, Can't find memory at 0xc0000!
3c523.c: No 3c523 cards found

I also tried changing the 'Pack Buffer RAM Address Range' setting of the
card, in the BIOS, to 0D8000-0DDFFF; I get the same error, but the 'Can't
find memory at ...' error changes to 0xd8000.

cat /proc/mca/slot3 produces a segfault, I think it was Invalid EAP, but
not sure as I am trying to fix the machine now so can't reproduce...

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
