Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280939AbRKLTGY>; Mon, 12 Nov 2001 14:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280933AbRKLTGO>; Mon, 12 Nov 2001 14:06:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280940AbRKLTGJ> convert rfc822-to-8bit; Mon, 12 Nov 2001 14:06:09 -0500
Date: Mon, 12 Nov 2001 11:01:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id LAA18088
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this kernel hopefully contains all the high-priority merges with Alan,
which means that as far as that is concerned, I'm done with 2.4.x and
ready to pass it on to Marcelo.

Which means that I'd also like people to double-check that there are no
embarrassing missing pieces due to the merge (or other patches).

Known issue: Al Viro fixed the nasty overflow with /proc/cpuinfo and
multiple CPU's, but only for x86. So other architectures need to convert
from the old "get_cpuinfo()" to the seq-file-based "show_cpuinfo()". The
conversion should be pretty mindless and straightforward.. (ie use
"seq_printf()"  instead of "sprintf()" etc - see arch/i386/kernel/setup.c
for the example code).

Changelog appeded,

		Linus

-----
pre4:
 - Mikael Pettersson: make proc_misc happy without modules
 - Arjan van de Ven: clean up acpitable implementation ("micro-acpi")
 - Anton Altaparmakov: LDM partition code update
 - Alan Cox: final (yeah, sure) small missing pieces
 - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore over suspend
 - Arjan van de Ven: remove power from pcmcia socket on card remove
 - Greg KH: USB updates
 - Neil Brown: multipath updates
 - Martin Dalecki: fix up some "asmlinkage" routine markings

pre3:
 - Alan Cox: more driver merging
 - Al Viro: make ext2 group allocation more readable

pre2:
 - Ivan Kokshaysky: fix alpha dec_and_lock with modules, for alpha config entry
 - Kai Germaschewski: ISDN updates
 - Jeff Garzik: network driver updates, sysv fs update
 - Kai Mäkisara: SCSI tape update
 - Alan Cox: large drivers merge
 - Nikita Danilov: reiserfs procfs information
 - Andrew Morton: ext3 merge
 - Christoph Hellwig: vxfs livelock fix
 - Trond Myklebust: NFS updates
 - Jens Axboe: cpqarray + cciss dequeue fix
 - Tim Waugh: parport_serial base_baud setting
 - Matthew Dharm: usb-storage Freecom driver fixes
 - Dave McCracken: wait4() thread group race fix

pre1:
 - me: fix page flags race condition Andrea found
 - David Miller: sparc and network updates
 - various: fix loop driver that thought it was part of the VM system
 - me: teach DRM about VM_RESERVED
 - Alan Cox: more merging

